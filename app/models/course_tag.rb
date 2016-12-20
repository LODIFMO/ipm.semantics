class CourseTag < ActiveRecord::Base
  belongs_to :course

  def self.upload(keyword)
    sparql = SPARQL::Client.new("http://dbpedia.org/sparql")
    solution = upload_rus sparql, keyword
    solution = upload_rus_mod(sparql, keyword) if solution.blank? || solution.size < 1 || solution.first[:description].value.size < 50
    solution = upload_eng(sparql, keyword) if solution.blank? || solution.size < 1
    solution = upload_eng_mod(sparql, keyword) if solution.blank? || solution.size < 1 || solution.first[:description].value.size < 50
    return '' if solution.blank? || solution.size < 1
    solution.first[:description].value
  end

  # get rus text from rdfs:comment
  def self.upload_rus(sparql, keyword)
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
  def self.upload_rus_mod(sparql, keyword)
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
  def self.upload_eng(sparql, keyword)
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
  def self.upload_eng_mod(sparql, keyword)
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

  # linkeduniversities.org
  def self.ou(keyword)
    sparql = SPARQL::Client.new('http://data.open.ac.uk/sparql')
    sparql.query(
      <<-SPARQL
        SELECT DISTINCT ?think ?description ?type ?label ?url ?title WHERE {
          ?think <http://purl.org/dc/terms/description> ?description .
          ?think <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?type .
          ?think <http://www.w3.org/2000/01/rdf-schema#label> ?label .
          OPTIONAL { ?think <http://dbpedia.org/property/url> ?url } .
          OPTIONAL { ?think <http://www.w3.org/TR/2010/WD-mediaont-10-20100608/title> ?title } .
          FILTER (regex(str(?description), "#{keyword}", "i" ))
        }
      SPARQL
    ).map do |item|
      url = item[:url].present? ? item[:url].value : ''
      title = item[:title].present? ? item[:title].value : ''
      {
        think: item[:think].value,
        description: item[:description].value,
        type: item[:type].value,
        label: item[:label].value,
        url: url,
        title: title
      }
    end
  end

  def self.ou_article(keyword)
    sparql = SPARQL::Client.new('http://data.open.ac.uk/sparql')
    sparql.query(
      <<-SPARQL
        SELECT DISTINCT ?think ?description ?type ?label ?url ?title WHERE {
          ?think <http://purl.org/ontology/bibo/abstract> ?description .
          ?think <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?type .
          ?think <http://www.w3.org/2000/01/rdf-schema#label> ?label .
          OPTIONAL { ?think <http://dbpedia.org/property/url> ?url } .
          OPTIONAL { ?think <http://www.w3.org/TR/2010/WD-mediaont-10-20100608/title> ?title } .
          FILTER (regex(str(?description), "#{keyword}", "i" ))
        }
      SPARQL
    ).map do |item|
      url = item[:url].present? ? item[:url].value : ''
      title = item[:title].present? ? item[:title].value : ''
      {
        think: item[:think].value,
        description: item[:description].value,
        type: item[:type].value,
        label: item[:label].value,
        url: url,
        title: title
      }
    end
  end

  def self.southampton(keyword)
    sparql = SPARQL::Client.new('http://sparql.data.southampton.ac.uk')
    sparql.query(
      <<-SPARQL
        SELECT DISTINCT ?think ?description ?type ?label ?url ?title WHERE {
          ?think <http://purl.org/dc/terms/description> ?description .
          ?think <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?type .
          ?think <http://www.w3.org/2000/01/rdf-schema#label> ?label .
          OPTIONAL { ?think <http://dbpedia.org/property/url> ?url } .
          OPTIONAL { ?think <http://www.w3.org/TR/2010/WD-mediaont-10-20100608/title> ?title } .
          FILTER (regex(str(?description), "#{keyword}", "i" ))
        }
      SPARQL
    ).map do |item|
      url = item[:url].present? ? item[:url].value : ''
      title = item[:title].present? ? item[:title].value : ''
      {
        think: item[:think].value,
        description: item[:description].value,
        type: item[:type].value,
        label: item[:label].value,
        url: url,
        title: title
      }
    end
  end

  def self.southampton_article(keyword)
    sparql = SPARQL::Client.new('http://sparql.data.southampton.ac.uk')
    sparql.query(
      <<-SPARQL
        SELECT DISTINCT ?think ?description ?type ?label ?url ?title WHERE {
          ?think <http://purl.org/ontology/bibo/abstract> ?description .
          ?think <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?type .
          ?think <http://www.w3.org/2000/01/rdf-schema#label> ?label .
          OPTIONAL { ?think <http://dbpedia.org/property/url> ?url } .
          OPTIONAL { ?think <http://www.w3.org/TR/2010/WD-mediaont-10-20100608/title> ?title } .
          FILTER (regex(str(?description), "#{keyword}", "i" ))
        }
      SPARQL
    ).map do |item|
      url = item[:url].present? ? item[:url].value : ''
      title = item[:title].present? ? item[:title].value : ''
      {
        think: item[:think].value,
        description: item[:description].value,
        type: item[:type].value,
        label: item[:label].value,
        url: url,
        title: title
      }
    end
  end
end
