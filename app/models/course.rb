class Course < ActiveRecord::Base
  include Bootsy::Container
  has_many :course_tags

  accepts_nested_attributes_for :course_tags, allow_destroy: true
end
