# frozen_string_literal: true

# == Schema Information
#
# Table name: news
#
#  id           :bigint           not null, primary key
#  body         :text
#  group_ids    :text             default([]), is an Array
#  public       :boolean          default(FALSE)
#  published_at :datetime
#  slug         :string
#  status       :integer          default("draft")
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#
# Indexes
#
#  index_news_on_slug  (slug) UNIQUE
#  news_title_idx      (title) USING gin
#
class News < ApplicationRecord
  extend HumanizeValues
  extend FriendlyId
  include HumanizeValue
  friendly_id :title, use: :slugged

  enum status: { draft: 0, published: 1, archived: 2 }

  validates :title, :body, :status, :published_at, presence: true

  before_save :update_group_ids

  scope :filter_by_title, ->(title) { where('unaccent(news.title) ILIKE ?', "%#{title}%") }
  scope :filter_by_company, -> { where.not(company_id: nil) }
  scope :filter_by_groups, -> { where.not(group_ids: []) }

  def self.searchable(query)
    filter_by_title(query)
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  private

  def update_group_ids
    self.group_ids = [] if group_ids == ['']
  end
end
