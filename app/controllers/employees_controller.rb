# frozen_string_literal: true

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

  def company_documents
    company_ids = current_employee.company_ids
    @company_documents = Document.where(company_id: company_ids).order(title: :asc).page(params[:page])
  end

  def group_documents
    group_ids = current_employee.group_ids
    @group_documents = Document.where(group_id: group_ids).order(title: :asc)
    @multi_group_documents = Document.where(group_ids: group_ids).order(title: :asc)
    @combine_documents = @group_documents + @multi_group_documents
    @combine_documents.sort_by(&:title)
  end

  def mine_documents
    @mine_documents = Document.where(employee_ids: [current_employee.id])
    @mine_documents.order(title: :asc).page(params[:page])
  end

  def company_news
    company_ids = current_employee.company_ids
    @company_news = News.where(company_id: company_ids).order(title: :asc).page(params[:page])
  end

  def group_news
    group_ids = current_employee.group_ids
    @group_news = News.where(group_ids: group_ids).order(title: :asc)
  end
end
