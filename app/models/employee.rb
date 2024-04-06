# frozen_string_literal: true

# == Schema Information
#
# Table name: employees
#
#  id                      :bigint           not null, primary key
#  address                 :string
#  age                     :integer
#  avatar                  :string
#  dob                     :date
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  full_name               :string
#  gender                  :integer          default("unknown")
#  info_contract           :text
#  job_title               :string
#  native_place            :string
#  phone_number            :string           default("")
#  relative_phone_number   :string           default("")
#  remember_created_at     :datetime
#  reset_password_sent_at  :datetime
#  reset_password_token    :string
#  slug                    :string
#  social_insurance_number :string
#  tax_code                :string
#  working_status          :integer          default("active")
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  employees_full_name_idx                  (full_name) USING gin
#  index_employees_on_email                 (email) UNIQUE
#  index_employees_on_full_name             (full_name) UNIQUE
#  index_employees_on_reset_password_token  (reset_password_token) UNIQUE
#  index_employees_on_slug                  (slug) UNIQUE
#
class Employee < ApplicationRecord
  extend HumanizeValues
  extend FriendlyId
  include HumanizeValue

  friendly_id :full_name, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :company_employees
  has_many :companies, through: :company_employees

  has_many :group_employees
  has_many :groups, through: :group_employees

  accepts_nested_attributes_for :company_employees, :group_employees

  enum gender: { female: 0, male: 1, unknown: 2 }
  enum working_status: { inactive: 0, active: 1 }

  validates :full_name, uniqueness: true

  def should_generate_new_friendly_id?
    slug.blank? || full_name_changed?
  end

  scope :filter_by_full_name, ->(full_name) { where('unaccent(employees.full_name) ILIKE ?', "%#{full_name}%") }

  def self.searchable(query)
    filter_by_full_name(query)
  end

  private

  def age
    year_of_birth = dob&.year
    Date.current.year - year_of_birth if year_of_birth
  end
end
