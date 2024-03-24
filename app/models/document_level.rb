# frozen_string_literal: true

# == Schema Information
#
# Table name: document_levels
#
#  id              :bigint           not null, primary key
#  documents_count :integer          default(0)
#  name            :string
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  document_levels_name_idx       (name) USING gin
#  index_document_levels_on_slug  (slug) UNIQUE
#
class DocumentLevel < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :documents, counter_cache: true, dependent: :destroy

  scope :filter_by_name, ->(name) { where('unaccent(document_levels.name) ILIKE ?', "%#{name}%") }

  def self.searchable(query)
    filter_by_name(query)
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
