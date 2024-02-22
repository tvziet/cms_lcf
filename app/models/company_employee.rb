# == Schema Information
#
# Table name: company_employees
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :bigint           not null
#  employee_id :bigint           not null
#
# Indexes
#
#  index_company_employees_on_company_id   (company_id)
#  index_company_employees_on_employee_id  (employee_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (employee_id => employees.id)
#
class CompanyEmployee < ApplicationRecord
  belongs_to :company
  belongs_to :employee
end
