namespace :lod do
  namespace :g do
    desc 'Generate ontology model for term'
    task :onto, [:keyword] => [:environment] do |_t, args|
      STDOUT.write "Start to generate ontology model\n"
      STDOUT.write "...keyword=#{args[:keyword]}\n"
      STDOUT.write "...finish\n"
    end
  end
end
