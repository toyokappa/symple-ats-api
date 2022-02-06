class ScheduleCoordinator
  # 1日の始まりと終り
  DAY_START = 9.hours
  DAY_END = 19.hours

  def exchange_busy_times_to_vacent_times(busy_times)
    bit_data = change_schedule_to_bit(busy_times)
    get_vacant_times(bit_data)
  end

  private

  # 予定全体をビット長に変更
  def change_schedule_to_bit(busy_times)
    schedule_bit_data = {}
    busy_times.each do |time|
      date, bit_data = change_event_to_bit(time)
      if schedule_bit_data.has_key?(date)
        schedule_bit_data[date] = make_logical_sum(schedule_bit_data[date], bit_data)
      else
        schedule_bit_data[date] = bit_data
      end
    end
    schedule_bit_data
  end

  # イベント単体をビット長に変更
  def change_event_to_bit(busy_time)
    event_start = busy_time[:start].to_i
    event_end = busy_time[:end].to_i
    date = busy_time[:start].to_date

    day_start = (date.in_time_zone + DAY_START).to_i
    day_end = (date.in_time_zone + DAY_END).to_i

    # 30分ごと
    segment_count = (day_end - day_start) / 60 / 60 * 2
    day_pointer = day_start

    bit_data = ''
    segment_count.times do
      # 15分毎に予定があるかどうかを確認しあれば該当の30分は予定ありとする
      condition1 = event_start <= day_pointer && day_pointer < event_end
      day_pointer += 900
      condition2 = event_start <= day_pointer && day_pointer < event_end
      day_pointer += 900

      if condition1 || condition2
        bit_data += '1'
      else
        bit_data += '0'
      end
    end
    [date.to_s, bit_data]
  end

  # ビット長同士の理論和を計算
  def make_logical_sum(bits1, bits2)
    bit_array1 = bits1.split('')
    bit_array2 = bits2.split('')
    bit_array1.map.with_index do |bit, i|
      if bit == '0' && bit_array2[i] == '0'
        '0'
      else
        '1'
      end
    end.join
  end

  # 予定から空き日程を算出
  def get_vacant_times(schedule_bit_data)
    vacant_times = []
    schedule_bit_data.each do |date, bit_data|
      day_start = (Time.zone.parse(date) + DAY_START).to_i
      day_end = (Time.zone.parse(date) + DAY_END).to_i
      day_pointer = day_start
      vacant_time_start, vacant_time_end = nil

      bit_data.split('').each do |bit|
        if bit == '0' && vacant_time_start.nil?
          vacant_time_start = day_pointer
          day_pointer += 1800
        elsif bit == '0' && vacant_time_start.present? && day_pointer < day_end - 1800
          day_pointer += 1800
        elsif bit == '1' && vacant_time_start.present?
          vacant_time_end = day_pointer
          # 予定が30分より多い場合に空き日程として追加
          if (vacant_time_end - vacant_time_start) > 1800
            vacant_times << { start: Time.zone.at(vacant_time_start), end: Time.zone.at(vacant_time_end) }
          end
          vacant_time_start, vacant_time_end = nil
          day_pointer += 1800
        elsif bit == '1' && vacant_time_start.nil?
          day_pointer += 1800
        elsif bit == '0' && day_pointer === day_end - 1800 && vacant_time_start.present?
          vacant_time_end = day_pointer + 1800
          if (vacant_time_end - vacant_time_start) > 1800
            vacant_times << { start: Time.zone.at(vacant_time_start), end: Time.zone.at(vacant_time_end) }
          end
          vacant_time_start, vacant_time_end = nil
        end
      end
    end
    vacant_times
  end
end
