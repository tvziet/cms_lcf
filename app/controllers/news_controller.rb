# frozen_string_literal: true

class NewsController < ApplicationController
  skip_before_action :authenticate_employee!, only: [:public]

  def show
    @news = News.find(params[:id])
  end

  def public
    @public_news = News.public_news
  end
end
