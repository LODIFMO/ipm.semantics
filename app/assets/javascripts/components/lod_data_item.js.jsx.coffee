{dl, dt, dd, a, div} = React.DOM
class @LodDataItem extends React.Component
  constructor: (props) ->
    super props

  render: ->
    div {className: 'well well-lg'},
      dl {},
        dt {}, 'URI'
        dd {},
          a {href: @props.item.think}, @props.item.think
        dt {}, 'description'
        dd {},
          div {dangerouslySetInnerHTML: {__html: @props.item.description}},
        dt {}, 'type'
        dd {},
          a {href: @props.item.type}, @props.item.type
        dt {}, 'label'
        dd {}, @props.item.label
        dt {}, 'URL'
        dd {},
          a {href: @props.item.url}, @props.item.url
        dt {}, 'title'
        dd {}, @props.item.title
