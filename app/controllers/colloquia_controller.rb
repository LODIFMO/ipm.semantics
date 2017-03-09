class ColloquiaController < ApplicationController
  before_action :set_colloquium, only: %i(show edit update destroy)
  skip_before_action :authenticate_user!, only: %i(show public_index)

  def index
    @colloquia = Colloquium.all.order(:day)
  end

  def public_index
    @colloquium = Colloquium.order(:day).last

    render :show, layout: 'public'
  end

  def show
    render layout: 'public'
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

  def edit
  end

  def update
    if @colloquium.update(colloquium_params)
      redirect_to colloquia_path, notice: 'colloquium was successfully updated.'
    else
      redner :edit
    end
  end

  def destroy
    @colloquium.destroy
    redirect_to colloquia_path, notice: 'Colloquium was successfully destroyed.'
  end

  private

  def colloquium_params
    params.require(:colloquium).permit(:title, :body, :day, :bootsy_image_gallery_id)
  end

  def set_colloquium
    @colloquium = Colloquium.find params[:id]
  end
end
