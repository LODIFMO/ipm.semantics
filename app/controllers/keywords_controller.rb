require 'sparql/client'

class KeywordsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i(index)

  def index
    @o = ou
    @oa = ou_article

    @s = southampton
    @sa = southampton_article
    render layout: 'public'
  end

  def ou_type(uri)
    if uri =~ /\/person\//
      'person'
    elsif uri =~ /\/podcast\//
      'podcast'
    elsif uri =~ /\/project\//
      'project'
    else
      'other'
    end
  end

  def ou
    sparql = SPARQL::Client.new('http://data.open.ac.uk/sparql')
    solutions = sparql.query(
      <<-SPARQL
        SELECT DISTINCT ?think ?description ?type ?label ?url ?title WHERE {
          ?think <http://purl.org/dc/terms/description> ?description .
          ?think <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?type .
          ?think <http://www.w3.org/2000/01/rdf-schema#label> ?label .
          OPTIONAL { ?think <http://dbpedia.org/property/url> ?url } .
          OPTIONAL { ?think <http://www.w3.org/TR/2010/WD-mediaont-10-20100608/title> ?title } .
          FILTER (regex(str(?description), "#{params[:keyword]}", "i" ))
        }
      SPARQL
    )

    results = []
    solutions.each do |item|
      next if item.blank?
      next if results.map { |r| r[:think] }.include?(item[:think].value)
      url = item[:url].present? ? item[:url].value : ''
      title = item[:title].present? ? item[:title].value : ''
      object = {
        think: item[:think].value,
        description: item[:description].value,
        type: item[:type].value,
        label: item[:label].value,
        url: url,
        title: title,
        t: ou_type(item[:think].value)
      }
      results << object
    end
    results.sort_by { |item| item[:think] }
  end

  def ou_article
    sparql = SPARQL::Client.new('http://data.open.ac.uk/sparql')
    solutions = sparql.query(
      <<-SPARQL
        SELECT DISTINCT ?think ?description ?type ?label ?url ?title WHERE {
          ?think <http://purl.org/ontology/bibo/abstract> ?description .
          ?think <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?type .
          ?think <http://www.w3.org/2000/01/rdf-schema#label> ?label .
          OPTIONAL { ?think <http://dbpedia.org/property/url> ?url } .
          OPTIONAL { ?think <http://www.w3.org/TR/2010/WD-mediaont-10-20100608/title> ?title } .
          FILTER (regex(str(?description), "#{params[:keyword]}", "i" ))
        }
      SPARQL
    )

    results = []
    solutions.each do |item|
      next if item.blank?
      next if results.map { |r| r[:think] }.include?(item[:think].value)
      url = item[:url].present? ? item[:url].value : ''
      title = item[:title].present? ? item[:title].value : ''
      object = {
        think: item[:think].value,
        description: item[:description].value,
        type: item[:type].value,
        label: item[:label].value,
        url: url,
        title: title,
        t: 'publication'
      }
      results << object
    end
    results.sort_by { |item| item[:think] }
  end

  def southampton
    sparql = SPARQL::Client.new('http://sparql.data.southampton.ac.uk')
    solutions = sparql.query(
      <<-SPARQL
        SELECT DISTINCT ?think ?description ?type ?label ?url ?title WHERE {
          ?think <http://purl.org/dc/terms/description> ?description .
          ?think <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?type .
          ?think <http://www.w3.org/2000/01/rdf-schema#label> ?label .
          OPTIONAL { ?think <http://dbpedia.org/property/url> ?url } .
          OPTIONAL { ?think <http://www.w3.org/TR/2010/WD-mediaont-10-20100608/title> ?title } .
          FILTER (regex(str(?description), "#{params[:keyword]}", "i" ))
        }
      SPARQL
    )

    results = []
    solutions.each do |item|
      next if item.blank?
      next if results.map { |r| r[:think] }.include?(item[:think].value)
      url = item[:url].present? ? item[:url].value : ''
      title = item[:title].present? ? item[:title].value : ''
      object = {
        think: item[:think].value,
        description: item[:description].value,
        type: item[:type].value,
        label: item[:label].value,
        url: url,
        title: title
      }
      results << object
    end
    results.sort_by { |item| item[:think] }
  end

  def southampton_article
    sparql = SPARQL::Client.new('http://sparql.data.southampton.ac.uk')
    solutions = sparql.query(
      <<-SPARQL
        SELECT DISTINCT ?think ?description ?type ?label ?url ?title WHERE {
          ?think <http://purl.org/ontology/bibo/abstract> ?description .
          ?think <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?type .
          ?think <http://www.w3.org/2000/01/rdf-schema#label> ?label .
          OPTIONAL { ?think <http://dbpedia.org/property/url> ?url } .
          OPTIONAL { ?think <http://www.w3.org/TR/2010/WD-mediaont-10-20100608/title> ?title } .
          FILTER (regex(str(?description), "#{params[:keyword]}", "i" ))
        }
      SPARQL
    )

    results = []
    solutions.each do |item|
      next if item.blank?
      next if results.map { |r| r[:think] }.include?(item[:think].value)
      url = item[:url].present? ? item[:url].value : ''
      title = item[:title].present? ? item[:title].value : ''
      object = {
        think: item[:think].value,
        description: item[:description].value,
        type: item[:type].value,
        label: item[:label].value,
        url: url,
        title: title
      }
      results << object
    end
    results.sort_by { |item| item[:think] }
  end
end
