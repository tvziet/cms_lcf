# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Company < ApplicationRecord
  has_many :groups

  has_many :company_employees
  has_many :employees, through: :company_employees

  default_scope { order(id: :asc) }
end
