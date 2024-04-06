# frozen_string_literal: true

class DocumentsController < ApplicationController
  def show
    @document = Document.find(params[:id])
  end

  def public
    @public_documents = Document.public_documents.order(title: :asc).page(params[:page])
  end
end
