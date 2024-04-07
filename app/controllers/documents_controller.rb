# frozen_string_literal: true

class DocumentsController < ApplicationController
  skip_before_action :authenticate_employee!, only: [:public]

  def show
    @document = Document.find(params[:id])
  end

  def public
    @public_documents = Document.public_documents.order(title: :asc).page(params[:page])
  end
end
