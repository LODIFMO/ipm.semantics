{div, input, button, i, span, p} = React.DOM

class @CourseTag extends React.Component
  constructor: (props) ->
    super props
    @state =
      count: []

  handleClick: (_event) ->
    count = @state.count
    count.push 1
    @setState(count: count)

  render: ->
    TagInput = React.createFactory(window.CourseTagInput)
    tags = @state.count
    div className: 'panel panel-danger',
      div className: 'panel-heading',
        span {}, 'Ключевые термины (experimental feature)'
        i className: 'fa fa-fw fa-exclamation'
        i className: 'fa fa-fw fa-exclamation'
      div className: 'panel-body',
        tags.map((_item, index) =>
          TagInput key: index
        )
        p {},
          button {
            type: 'button',
            className: 'btn btn-default btn-xs',
            onClick: ((e) => @handleClick(e))
          },
            i className: 'fa fa-fw fa-plus',
