require 'sparql/client'

module Api
  class CoursesController < ApplicationController
    skip_before_action :authenticate_user!, only: %i(keyword)

    def keyword
      @description = upload params[:keyword]
      render 'api/courses/keyword.json.jbuilder'
    end

    private

    def upload(keyword)
      sparql = SPARQL::Client.new("http://dbpedia.org/sparql")
      solution = upload_rus sparql, keyword
      solution = upload_rus_mod(sparql, keyword) if solution.blank? || solution.size < 1 || solution.first[:description].value.size < 50
      solution = upload_eng(sparql, keyword) if solution.blank? || solution.size < 1
      solution = upload_eng_mod(sparql, keyword) if solution.blank? || solution.size < 1 || solution.first[:description].value.size < 50
      return '' if solution.blank? || solution.size < 1
      solution.first[:description].value
    end

    # get rus text from rdfs:comment
    def upload_rus(sparql, keyword)
      sparql.query(
        <<-SPARQL
          SELECT DISTINCT ?concept ?description
          WHERE {
            ?concept rdfs:comment ?description .
            ?concept rdfs:label "#{keyword}"@en .
            FILTER ( lang(?description) = "ru" )
          }
        SPARQL
      )
    end

    # get rus text from dbo:abstract
    def upload_rus_mod(sparql, keyword)
      sparql.query(
        <<-SPARQL
          SELECT DISTINCT ?concept ?description
          WHERE {
            ?concept dbo:abstract ?description .
            ?concept rdfs:label "#{keyword}"@en .
            FILTER ( lang(?description) = "ru" )
          }
        SPARQL
      )
    end

    # get eng text from rdfs:comment
    def upload_eng(sparql, keyword)
      sparql.query(
        <<-SPARQL
          SELECT DISTINCT ?concept ?description
          WHERE {
            ?concept rdfs:comment ?description .
            ?concept rdfs:label "#{keyword}"@en .
            FILTER ( lang(?description) = "en" )
          }
        SPARQL
      )
    end

    # get eng text from dbo:abstract
    def upload_eng_mod(sparql, keyword)
      sparql.query(
        <<-SPARQL
          SELECT DISTINCT ?concept ?description
          WHERE {
            ?concept dbo:abstract ?description .
            ?concept rdfs:label "#{keyword}"@en .
            FILTER ( lang(?description) = "en" )
          }
        SPARQL
      )
    end
  end
end
