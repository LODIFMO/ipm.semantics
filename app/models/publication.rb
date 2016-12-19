class Publication < ActiveRecord::Base
  has_many :people_publication
  has_many :people, through: :people_publication

  has_many :projects_publication
  has_many :projects, through: :projects_publication
end
