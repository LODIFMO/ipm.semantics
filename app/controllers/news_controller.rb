class NewsController < ApplicationController
  def index
    @news = News.all.order(created_at: :desc)
  end

  def new
    @news = News.new
  end
end
