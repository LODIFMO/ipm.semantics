{div, h1, a, li, ul, h1, i, img, table, tbody, thead, th, tr} = React.DOM

class @KeywordShow extends React.Component
  constructor: (props) ->
    super props

  render: ->
    LodDataItem = React.createFactory(window.LodDataItem)
    div {className: 'container'},
      div {className: 'page-header'},
        h1 {}, @props.keyword
      div {},
        ul {className: 'nav nav-tabs', role: 'tablist'},
          li {className: 'active', role: 'presentation'},
            a {href: '#ou', 'aria-controls': 'html', role: 'tab', 'data-toggle': 'tab' },
              img {src: @props.ou_png}
              ' Open University'
          li {role: 'presentation'},
            a {href: '#southampton', 'aria-controls': 'html', role: 'tab', 'data-toggle': 'tab' },
              img {src: @props.southampton_png, height: 20, width: 20}
              ' University of Southampton'
      div {className: 'tab-content'},
        div {className: 'tab-pane active', id: 'ou', role: 'tabpanel'},
          div {className: 'panel panel-default'},
            div {className: 'panel-body'},
              ul {className: 'nav nav-tabs', role: 'tablist'},
                li {role: 'presentation', className: 'active'},
                  a {href: '#people', 'aria-controls': 'html', role: 'tab', 'data-toggle': 'tab'}, 'People'
                li {role: 'presentation'},
                  a {href: '#podcasts', 'aria-controls': 'html', role: 'tab', 'data-toggle': 'tab'}, 'Podcasts'
                li {role: 'presentation'},
                  a {href: '#projects', 'aria-controls': 'html', role: 'tab', 'data-toggle': 'tab'}, 'Projects'
                li {role: 'presentation'},
                  a {href: '#publications', 'aria-controls': 'html', role: 'tab', 'data-toggle': 'tab'}, 'Publications'
                li {role: 'presentation'},
                  a {href: '#others', 'aria-controls': 'html', role: 'tab', 'data-toggle': 'tab'}, 'Others'
              div {className: 'tab-content'},
                div {className: 'tab-pane active', id: 'people', role: 'tabpanel'},
                  div {className: 'panel panel-default'},
                    div {className: 'panel-body'}, 'people'
                div {className: 'tab-pane', id: 'podcasts', role: 'tabpanel'},
                  div {className: 'panel panel-default'},
                    div {className: 'panel-body'}, 'podcasts'
                div {className: 'tab-pane', id: 'projects', role: 'tabpanel'},
                  div {className: 'panel panel-default'},
                    div {className: 'panel-body'}, 'projects'
                div {className: 'tab-pane', id: 'publications', role: 'tabpanel'},
                  div {className: 'panel panel-default'},
                    div {className: 'panel-body'}, 'publications'
                div {className: 'tab-pane', id: 'others', role: 'tabpanel'},
                  div {className: 'panel panel-default'},
                    div {className: 'panel-body'}, 'Other'
              div {className: 'panel panel-warning'},
                div {className: 'panel-heading'}, 'Data'
                div {className: 'panel-body'},
                  @props.ou_data.map((item, index) =>
                    LodDataItem item: item, key: index
                  )
              div {className: 'panel panel-info'},
                div {className: 'panel-heading'}, 'Publications'
                div {className: 'panel-body'},
                  @props.ou_a_data.map((item, index) =>
                    LodDataItem item: item, key: index
                  )
        div {className: 'tab-pane', id: 'southampton', role: 'tabpanel'},
          div {className: 'panel panel-default'},
            div {className: 'panel-body'},
              div {className: 'panel panel-warning'},
                div {className: 'panel-heading'}, 'Data'
                div {className: 'panel-body'},
                  @props.s_data.map((item, index) =>
                    LodDataItem item: item, key: index
                  )
              div {className: 'panel panel-info'},
                div {className: 'panel-heading'}, 'Publications'
                div {className: 'panel-body'},
                  @props.s_a_data.map((item, index) =>
                    LodDataItem item: item, key: index
                  )
