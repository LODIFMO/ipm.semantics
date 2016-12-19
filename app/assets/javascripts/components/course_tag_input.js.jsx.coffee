{p, input} = React.DOM

class @CourseTagInput extends React.Component
  render: ->
    p {},
      input {
        className: 'form-control',
        placeholder: 'Термин (rus/eng)',
        name: 'course[course_tags_attributes][][word]'
      },
