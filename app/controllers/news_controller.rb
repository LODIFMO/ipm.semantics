class NewsController < ApplicationController
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

  private

  def news_params
    params.require(:news).permit(:title, :body, :bootsy_image_gallery_id)
  end
end
