{div} = React.DOM

class @TypeaheadListItem extends React.Component
  constructor: (props) ->
    super props
    @state =
      hasMouse: false

  compStyle: {
    cursor: 'pointer'
  }

  handleMouseEnter: (_event) ->
    @setState(hasMouse: true)

  handleMouseLeave: (_event) ->
    @setState(hasMouse: false)

  handleClick: (event) ->
    @props.handleClick(@props.item, event)

  render: ->
    className = 'label-info' if @state.hasMouse
    div {
      className: className,
      style: @compStyle,
      onMouseEnter: ((e) => @handleMouseEnter(e)),
      onMouseLeave: ((e) => @handleMouseLeave(e)),
      onClick: ((e) => @handleClick(e))
      }, "#{@props.item['name']}"
