class PeoplePublication < ActiveRecord::Base
  self.table_name = 'people_publications'

  belongs_to :people, class_name: 'Person', foreign_key: 'person_id'
  belongs_to :publications, class_name: 'Publication', foreign_key: 'publication_id'
end
