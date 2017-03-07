class Course < ActiveRecord::Base
  include Bootsy::Container
  has_many :course_tags

  accepts_nested_attributes_for :course_tags, allow_destroy: true

  def to_react
    {
      description: description,
      id: id,
      title: title,
      tags: course_tags.map { |tag| {id: tag.id, word: tag.word} }
    }
  end
end
