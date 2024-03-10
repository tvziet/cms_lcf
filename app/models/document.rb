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

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def inter_groups
    Group.where(id: group_ids)
  end
end
