namespace :lod do
  namespace :g do
    desc 'Generate ontology model for term'
    task :onto, [:keyword] => [:environment] do |_t, args|
      STDOUT.write "Start to generate ontology model\n"
      STDOUT.write "...keyword=#{args[:keyword]}\n"
      dbpedia = SPARQL::Client.new('http://dbpedia.org/sparql')
      solutions = []
      solutions << CourseTag.upload_rus(dbpedia, args[:keyword].capitalize)
      solutions << CourseTag.upload_rus_mod(dbpedia, args[:keyword].capitalize)
      solutions << CourseTag.upload_eng(dbpedia, args[:keyword].capitalize)
      solutions << CourseTag.upload_eng_mod(dbpedia, args[:keyword].capitalize)
      STDOUT.write "...upload from dbpedia\n"
      graph = RDF::Graph.new
      keyword = args[:keyword].tr(' ', '_')
      IPM = RDF::Vocabulary.new("http://www.lod.ifmo.ru/ipm/semantics#")
      count = 0
      # Create classes
      graph << [IPM.Keyword, RDF.type, RDF::OWL.Class]
      graph << [IPM.Resource, RDF.type, RDF::OWL.Class]

      # Add keyword
      graph << [RDF::URI(IPM[keyword]), RDF.type, RDF::RDFS.Resource]
      graph << [RDF::URI(IPM[keyword]), RDF.type, RDF::OWL.NamedIndividual]
      graph << [RDF::URI(IPM[keyword]), RDF.type, IPM.Keyword]
      graph << [RDF::URI(IPM[keyword]), RDF::RDFS.label, args[:keyword]]

      # Add dbpedia
      solutions.each do |s|
        next if s.blank?
        object = s.first
        node = "keyword_node_#{count}"
        graph << [RDF::URI(IPM[node]), RDF.type, RDF::RDFS.Resource]
        graph << [RDF::URI(IPM[node]), RDF.type, IPM.Resource]
        graph << [RDF::URI(IPM[node]), RDF.type, RDF::OWL.NamedIndividual]
        graph << [RDF::URI(IPM[node]), RDF::RDFS.comment, object[:description].value]
        graph << [RDF::URI(IPM[node]), RDF::RDFS.seeAlso, object[:concept].value]
        graph << [RDF::URI(IPM[node]), RDF.type, RDF::URI(object[:concept].value)]
        graph << [RDF::URI(IPM[keyword]), IPM.link_to, RDF::URI(IPM[node])]
        count += 1
      end

      # Add open university
      ou = CourseTag.ou(args[:keyword]) | CourseTag.ou_article(args[:keyword])
      count = 0
      ou.each do |object|
        next if object.blank?
        node = "keyword_node_ou_#{count}"
        graph << [RDF::URI(IPM[node]), RDF.type, RDF::RDFS.Resource]
        graph << [RDF::URI(IPM[node]), RDF.type, IPM.Resource]
        graph << [RDF::URI(IPM[node]), RDF.type, RDF::OWL.NamedIndividual]
        graph << [RDF::URI(IPM[node]), RDF::RDFS.comment, object[:description]]
        graph << [RDF::URI(IPM[node]), RDF::RDFS.seeAlso, object[:think]]
        graph << [RDF::URI(IPM[node]), RDF.type, RDF::URI(object[:think])]
        graph << [RDF::URI(IPM[node]), RDF.type, RDF::URI(object[:type])]
        graph << [RDF::URI(IPM[node]), RDF::RDFS.label, object[:label]]
        graph << [RDF::URI(IPM[keyword]), IPM.link_to, RDF::URI(IPM[node])]
        count += 1
      end
      STDOUT.write "...upload from ou\n"

      # Add southampton
      southampton = CourseTag.southampton(args[:keyword]) | CourseTag.southampton_article(args[:keyword])
      count = 0
      southampton.each do |object|
        next if object.blank?
        node = "keyword_node_southampton_#{count}"
        graph << [RDF::URI(IPM[node]), RDF.type, RDF::RDFS.Resource]
        graph << [RDF::URI(IPM[node]), RDF.type, IPM.Resource]
        graph << [RDF::URI(IPM[node]), RDF.type, RDF::OWL.NamedIndividual]
        graph << [RDF::URI(IPM[node]), RDF::RDFS.comment, object[:description]]
        graph << [RDF::URI(IPM[node]), RDF::RDFS.seeAlso, object[:think]]
        graph << [RDF::URI(IPM[node]), RDF.type, RDF::URI(object[:think])]
        graph << [RDF::URI(IPM[node]), RDF.type, RDF::URI(object[:type])]
        graph << [RDF::URI(IPM[node]), RDF::RDFS.label, object[:label]]
        graph << [RDF::URI(IPM[keyword]), IPM.link_to, RDF::URI(IPM[node])]
        count += 1
      end
      STDOUT.write "...upload from southampton\n"

      # Save to file
      prefixes = {
        base: "http://www.lod.ifmo.ru/ipm/semantics#",
        owl: "http://www.w3.org/2002/07/owl#",
        rdf: "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        xml: "http://www.w3.org/XML/1998/namespace",
        xsd: "http://www.w3.org/2001/XMLSchema#",
        rdfs: "http://www.w3.org/2000/01/rdf-schema#"
      }
      RDF::Turtle::Writer.open("#{keyword}.ttl", prefixes: prefixes) { |writer| writer << graph }
      STDOUT.write "...finish\n"
    end
  end
end
