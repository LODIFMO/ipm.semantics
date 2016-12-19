class PeopleController < ApplicationController
  before_action :set_person, only: [:edit, :update, :destroy, :show]
  skip_before_action :authenticate_user!, only: %i(show public_index)

  def index
    @people = Person.all
  end

  def public_index
    @people = Person.all
    render layout: 'public'
  end

  def show
    url = 'http://lobid.org'
    conn = Faraday.new(url: url) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.response :json
    end

    response = conn.get('resource', q: 'Mouromtsev', format: 'full')
    @result = response.body

    # api_key = 'AhiIyVBwqOlXZN7duzMetrYnHFDE56vx'

    # springer_api_key = '8eab8c31c13bd807cd3740b32158da69'
    springer_url = 'http://api.springer.com/metadata/json?api_key=8eab8c31c13bd807cd3740b32158da69&q=Mouromtsev'
    springer_uri = URI(springer_url)
    springer_response = Net::HTTP.get(springer_uri)
    @springer_result = JSON.parse(springer_response)

    render layout: 'public'
  end

  def new
    @person = Person.new
  end

  def cube
    render 'cube/person'
  end

  def edit
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to people_url, notice: 'Person was successfully created.'
    else
      render :new
    end
  end

  def update
    if @person.update(person_params)
      redirect_to people_url, notice: 'Person was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @person.destroy
    redirect_to people_url, notice: 'Person was successfully destroyed.'
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params
      .require(:person)
      .permit(:linkedin, :google_plus, :scopus, :university, :awards,
              :impact_story, :google_scholar, :cv, :orcid, :name,
              :biography, :email, :room, :laboratory, :website, :github,
              :education, :twitter, :photo, :fb,
              project_ids: [], publication_ids: [])
  end
end
