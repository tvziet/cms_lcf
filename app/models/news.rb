# == Schema Information
#
# Table name: news
#
#  id           :bigint           not null, primary key
#  body         :text
#  group_ids    :text             default([]), is an Array
#  public       :boolean          default(FALSE)
#  published_at :datetime
#  status       :integer          default("draft")
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#
class News < ApplicationRecord
  extend HumanizeValues
  include HumanizeValue

  enum status: { draft: 0, published: 1, archived: 2 }

  validates :title, :body, :status, :published_at, presence: true

  before_save :update_group_ids

  private

  def update_group_ids
    self.group_ids = [] if group_ids == ['']
  end
end
