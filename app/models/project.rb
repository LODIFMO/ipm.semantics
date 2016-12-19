class Project < ActiveRecord::Base
  has_many :projects_publication
  has_many :publications, through: :projects_publication

  has_many :people_project
  has_many :people, through: :people_project

  serialize :keywords, JSON
end
