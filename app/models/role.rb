# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  level      :integer          default("low")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Role < ApplicationRecord
  extend HumanizeValues
  include HumanizeValue

  enum level: { low: 0, medium: 1, high: 2 }

  validates :level, presence: true, uniqueness: true
end
