# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @carousels = Carousel.all
    @news = News.public_news.limit(10)
    @documents = Document.public_documents.limit(10)
  end
end
