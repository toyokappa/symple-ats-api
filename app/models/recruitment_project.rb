# == Schema Information
#
# Table name: recruitment_projects
#
#  id              :bigint           not null, primary key
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint
#
class RecruitmentProject < ApplicationRecord
  has_many :recruitment_selections, -> { order(:position) }, dependent: :destroy
  has_many :recruitment_histories, through: :recruitment_selections
  belongs_to :organization

  def chart_labels
    labels = recruitment_selections.where.not(selection_type: %i[failure decline other]).map {|selection| selection.name }
    labels << '' # 描画用に空のラベルを追加
  end

  def chart_values(category: nil)
    histories = recruitment_histories.includes(candidate: :channel)
    histories = histories.where(channels: { category: category }) if category.present?
    histories = histories.where.not(selected_at: nil)
    values = histories.joins(:recruitment_selection).group('recruitment_selections.position').count.values
    values += Array.new((chart_labels.length - 1) - values.length, 0) # 値がない項目は0で埋める
    values << values.last # 描画用に最後の値と同じ値を追加
  end

  def to_table_headers(labels)
    headers = []
    labels[...-1].each.with_index do |label, index|
      headers << { text: label, value: "selection#{index}", align: "center" }
      next if index >= labels[...-1].length - 1
      headers << { text: '', value: "selection#{index}Percentage", align: "center" }
    end
    headers
  end

  def to_table_values(values)
    hash = {}
    values[...-1].each.with_index do |value, index|
      hash["selection#{index}"] = value
      next if index >= values[...-1].length - 1
      next hash["selection#{index}Percentage"] = '-' if value === 0
      hash["selection#{index}Percentage"] = "#{(values[index + 1] / value).to_f * 100}%"
    end
    hash
  end

  def chart_json
    all_values = chart_values
    chart_datasets = [{ dataName: "全体", values: all_values, sortable: false } ]

    table_values = to_table_values(all_values)
    table_values[:dataName] = "全体"
    table_datasets = [table_values]

    Channel.enums_i18n(:category).each do |category, label|
      values = chart_values(category: category)
      next if values.compact.blank?

      chart_datasets << { dataName: label, values: values }

      t_values = to_table_values(values)
      t_values[:dataName] = label
      table_datasets << t_values
    end

    labels = chart_labels
    headers = [{ text: "区分", value: 'dataName' }]
    headers += to_table_headers(labels)

    {
      chart: {
        labels: labels,
        datasets: chart_datasets,
      },
      table: {
        headers: headers,
        datasets: table_datasets,
      },
    }
  end
end
