# frozen_string_literal: true

# == Schema Information
#
# Table name: administrators
#
#  id                     :bigint           not null, primary key
#  avatar                 :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :bigint
#
# Indexes
#
#  index_administrators_on_email                 (email) UNIQUE
#  index_administrators_on_reset_password_token  (reset_password_token) UNIQUE
#  index_administrators_on_role_id               (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class Administrator < ApplicationRecord
  extend HumanizeValues
  include HumanizeValue

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  belongs_to :role

  def high_level?
    role.level == 'high'
  end

  def medium_level?
    role.level == 'medium'
  end

  def low_level?
    role.level == 'low'
  end
end
