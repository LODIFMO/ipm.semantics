{div, h1, p} = React.DOM

class @CoursesShow extends React.Component
  constructor: (props) ->
    super props
    @state =
      keywords: props.tags

  render: ->
    CourseKeyword = React.createFactory(window.CourseKeyword)
    div {className: 'container'},
      div {className: 'page-header'},
        h1 {}, @props.title
      div {className: 'panel panel-default'},
        div {className: 'panel-heading'}, 'Описание'
        div {className: 'panel-body'},
          div {dangerouslySetInnerHTML: {__html: @props.description}},
      div {className: 'panel panel-default'},
        div {className: 'panel-heading'}, 'Ключевые термины'
        div {className: 'panel-body'},
          div {},
            @state.keywords.map((item, index) =>
              CourseKeyword item: item, key: index
            )
          
