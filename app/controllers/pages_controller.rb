# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @carousels = Carousel.all
    @news = News.public_news.limit(10)
    @documents = Document.public_documents.limit(10)
  end

  def search
    # Search for colleague
    colleagues = Employee.filter_by_full_name(params[:q])
    # Search for news
    news = News.filter_by_title(params[:q])
    # Search for documents
    documents = Document.filter_by_title(params[:q])
    @results = colleagues + news + documents
  end
end
