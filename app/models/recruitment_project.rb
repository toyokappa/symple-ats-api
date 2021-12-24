# == Schema Information
#
# Table name: recruitment_projects
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class RecruitmentProject < ApplicationRecord
  has_many :recruitment_selections, -> { order(:position) }, dependent: :destroy
  has_many :recruitment_histories, through: :recruitment_selections

  # グラフ関連のテストを書き忘れないように
  def chart_labels
    labels = recruitment_selections.where.not(selection_type: %i[failure decline other]).map {|selection| selection.name }
    labels << '' # 描画用に空のラベルを追加
  end

  def chart_values(category: nil)
    histories = recruitment_histories.includes(candidate: :channel)
    histories = histories.where(channels: { category: category }) if category.present?
    histories = histories.where.not(selected_at: nil)
    values = histories.joins(:recruitment_selection).group('recruitment_selections.position').count.values
    values << values.last # 描画用に最後の値と同じ値を追加
  end

  def chart_datasets
    datasets = [{ dataName: "全体", values: chart_values } ]
    Channel.enums_i18n(:category).each do |category, label|
      values = chart_values(category: category)
      next if values.compact.blank?

      datasets << { dataName: label, values: values }
    end

    datasets
  end

  def chart_data
    {
      labels: chart_labels,
      datasets: chart_datasets,
    }
  end
end
