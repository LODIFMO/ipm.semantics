class ColloquiaController < ApplicationController
  def index
    @colloquia = Colloquium.all.order(:day)
  end
end
