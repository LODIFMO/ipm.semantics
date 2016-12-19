class PeopleProject < ActiveRecord::Base
  self.table_name = 'people_projects'

  belongs_to :project, class_name: 'Project', foreign_key: 'project_id'
  belongs_to :people, class_name: 'Person', foreign_key: 'person_id'
end
