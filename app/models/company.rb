# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  logo       :string
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  companies_name_idx       (name) USING gin
#  index_companies_on_slug  (slug) UNIQUE
#
class Company < ApplicationRecord
  mount_uploader :logo, ImageUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :groups, dependent: :destroy

  has_many :company_employees
  has_many :employees, through: :company_employees

  after_commit :remove_logo!, on: :destroy
  after_commit :remove_previously_stored_logo, on: :update

  scope :filter_by_name, ->(name) { where('unaccent(companies.name) ILIKE ?', "%#{name}%") }
  default_scope { order(id: :asc) }

  def self.searchable(query)
    filter_by_name(query)
  end

  def num_of_employees
    employees.count
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
