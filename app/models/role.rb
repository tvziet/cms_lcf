# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Role < ApplicationRecord
  enum role: { low: 0, medium: 1, high: 2 }
end
