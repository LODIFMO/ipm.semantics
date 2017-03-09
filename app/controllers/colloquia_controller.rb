class ColloquiaController < ApplicationController
  before_action :set_colloquium, only: %i(show edit update destroy)
  skip_before_action :authenticate_user!, only: %i(show public_index)

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

  private

  def colloquium_params
    params.require(:colloquium).permit(:title, :body, :day, :bootsy_image_gallery_id)
  end

  def set_colloquium
    @colloquium = Colloquium.find params[:id]
  end
end
