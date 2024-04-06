# frozen_string_literal: true

# == Schema Information
#
# Table name: documents
#
#  id                :bigint           not null, primary key
#  body              :text
#  employee_ids      :text             default([]), is an Array
#  group_ids         :text             default([]), is an Array
#  slug              :string
#  title             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  company_id        :integer
#  document_level_id :bigint
#  group_id          :integer
#
# Indexes
#
#  documents_title_idx                   (title) USING gin
#  index_documents_on_document_level_id  (document_level_id)
#  index_documents_on_slug               (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (document_level_id => document_levels.id)
#
class Document < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :document_level, counter_cache: true
  belongs_to :company, optional: true
  belongs_to :group, optional: true

  scope :filter_by_title, ->(title) { where('unaccent(documents.title) ILIKE ?', "%#{title}%") }
  scope :filter_by_company, -> { where.not(company_id: nil) }
  scope :filter_by_group, -> { where.not(group_id: nil) }
  scope :filter_by_groups, -> { where.not(group_ids: []) }

  validates :title, :body, presence: true

  scope :public_documents, -> { where(document_level_id: 4) }

  def self.searchable(query)
    filter_by_title(query)
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def inter_groups
    Group.where(id: group_ids)
  end
end
