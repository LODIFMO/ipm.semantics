class ResearchAreasController < ApplicationController
  before_action :set_area, only: :destroy
  skip_before_action :authenticate_user!, only: %i(public_index)

  def index
    @areas = ResearchArea.all.order(:created_at)
    return if @areas.size <= 0
    render_areas
  rescue => e
    @error = '<strong>При запросе к <i>lod.ifmo/REST</i> произошла ошибка!</strong><br /> Обратитесь к администратору для решения проблемы.'
    logger.tagged('ResearchAreasController', self.class) do
      logger.error e.message
      logger.error e.backtrace.join("\n")
    end
  end

  def public_index
    @areas = ResearchArea.all
    render_areas
    render layout: 'public'
  rescue => e
    logger.tagged('ResearchAreasController_Public', self.class) do
      logger.error e.message
      logger.error e.backtrace.join("\n")
    end
    redirect_to '/'
  end

  def new
    url = "#{Rails.configuration.x.lod_ifmo_api_url}/research_areas.json"

    conn = Faraday.new(url: url) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.response :json
    end

    response = conn.get('')
    @areas = response.body
  end

  def create
    @area = ResearchArea.new(research_area_params)

    if @area.save
      redirect_to research_areas_url
    else
      render :new
    end
  end

  def destroy
    @area.destroy
    redirect_to research_areas_url
  end

  private

  def research_area_params
    params.require(:research_area).permit(:uri)
  end

  def render_areas
    uris = @areas.map(&:uri)
    url = "#{Rails.configuration.x.lod_ifmo_api_url}/research_areas"

    conn = Faraday.new(url: url) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.response :json
    end

    response = conn.get('find_by_uri', uri: uris)
    @result = response.body
  end

  def set_area
    @area = ResearchArea.find params[:id]
  end
end
