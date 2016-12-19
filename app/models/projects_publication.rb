class ProjectsPublication < ActiveRecord::Base
  self.table_name = 'projects_publications'

  belongs_to :project, class_name: 'Project', foreign_key: 'project_id'
  belongs_to :publication, class_name: 'Publication', foreign_key: 'publication_id'
end
