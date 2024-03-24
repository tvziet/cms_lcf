# frozen_string_literal: true

# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#
# Indexes
#
#  index_groups_on_company_id  (company_id)
#  index_groups_on_slug        (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Group < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :company

  has_many :group_employees
  has_many :employees, through: :group_employees

  def business_name
    "#{name} - (#{company.name})"
  end

  def num_of_employees
    employees.size
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
