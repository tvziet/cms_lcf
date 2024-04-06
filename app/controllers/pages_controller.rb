# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @carousels = Carousel.all
    @mine_documents = Document.where(employee_id: current_employee.id)
    @my_company_documents = Document.where(company_id: current_employee.company_ids)
    @my_group_documents = Document.where(group_ids: current_employee.group_ids)
  end
end
