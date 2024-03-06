# frozen_string_literal: true

# == Schema Information
#
# Table name: document_levels
#
#  id              :bigint           not null, primary key
#  documents_count :integer          default(0)
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class DocumentLevel < ApplicationRecord
  has_many :documents, counter_cache: true
end
