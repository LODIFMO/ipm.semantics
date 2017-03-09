class NewsController < ApplicationController
  before_action :set_news, only: %i(show edit update destroy)
  skip_before_action :authenticate_user!, only: %i(show public_index)

  def index
    @news = News.all.order(created_at: :desc)
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new news_params

    if @news.save
      redirect_to '/admin/news', notice: 'News was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @news.update(news_params)
      redirect_to '/admin/news', notice: 'News was successfully updated.'
    else
      render :edit
    end
  end

  private

  def news_params
    params.require(:news).permit(:title, :body, :bootsy_image_gallery_id)
  end

  def set_news
    @news = News.find params[:id]
  end
end
