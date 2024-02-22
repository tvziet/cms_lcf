# == Schema Information
#
# Table name: group_employees
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :bigint           not null
#  group_id    :bigint           not null
#
# Indexes
#
#  index_group_employees_on_employee_id  (employee_id)
#  index_group_employees_on_group_id     (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (group_id => groups.id)
#
class GroupEmployee < ApplicationRecord
  belongs_to :group
  belongs_to :employee
end
