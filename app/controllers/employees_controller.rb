class EmployeesController < ApplicationController
  def work_info; end

  def personal_info; end

  def contract_info; end

  def colleague_info
    company_ids = current_employee.company_ids
    companies = Company.where(id: company_ids)
    @colleagues = []
    companies.find_each do |company|
      @colleagues << company.employees
    end

    @colleagues.flatten!
    @colleagues.delete(current_employee)
  end
end
