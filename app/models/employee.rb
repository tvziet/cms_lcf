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
#  remember_created_at     :datetime
#  reset_password_sent_at  :datetime
#  reset_password_token    :string
#  social_insurance_number :string
#  tax_code                :string
#  working_status          :integer          default("active")
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_employees_on_email                 (email) UNIQUE
#  index_employees_on_reset_password_token  (reset_password_token) UNIQUE
#
class Employee < ApplicationRecord
  extend HumanizeValues
  include HumanizeValue

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  enum gender: { female: 0, male: 1, unknown: 2 }
  enum working_status: { inactive: 0, active: 1 }

  def has_avatar?
    avatar.present?
  end
end
