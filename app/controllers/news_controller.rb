# frozen_string_literal: true

class NewsController < ApplicationController
  def show
    @news = News.find(params[:id])
  end

  def public
    @public_news = News.public_news
  end
end
