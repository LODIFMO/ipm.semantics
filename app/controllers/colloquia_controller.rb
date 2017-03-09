class ColloquiaController < ApplicationController
  def index
    @colloquia = Colloquium.all.order(:day)
  end

  def new
    @colloquium = Colloquium.new
  end

  def create
    @colloquium = Colloquium.new colloquium_params

    if @colloquium.save
      redirect_to colloquia_path, notice: 'Colloquium was successfully created.'
    else
      render :new
    end
  end

  def colloquium_params
    params.require(:colloquium).permit(:title, :body, :day, :bootsy_image_gallery_id)
  end
end
