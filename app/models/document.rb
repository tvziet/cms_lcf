# == Schema Information
#
# Table name: documents
#
#  id                :bigint           not null, primary key
#  body              :text
#  group_ids         :text             default([]), is an Array
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
#
# Foreign Keys
#
#  fk_rails_...  (document_level_id => document_levels.id)
#
class Document < ApplicationRecord
  belongs_to :document_level
end
