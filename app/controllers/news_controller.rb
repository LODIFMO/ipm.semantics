class NewsController < ApplicationController
  before_action :set_news, only: %i(show edit update destroy)
  skip_before_action :authenticate_user!, only: %i(show public_index)

  def index
    @news = News.all.order(created_at: :desc)
  end

  def public_index
    @news = News.all.order(created_at: :desc)
    render layout: 'public'
  end

  def new
    @news = News.new
  end

  def show
    render layout: 'public'
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

  def destroy
    @news.destroy
    redirect_to '/admin/news', notice: 'News was successfully destroyed.'
  end

  private

  def news_params
    params.require(:news).permit(:title, :body, :short_body, :bootsy_image_gallery_id)
  end

  def set_news
    @news = News.find params[:id]
  end
end
