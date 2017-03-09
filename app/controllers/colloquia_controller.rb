class ColloquiaController < ApplicationController
  def index
    @colloquia = Colloquium.all.order(:day)
  end

  def new
    @colloquium = Colloquium.new
  end
end
