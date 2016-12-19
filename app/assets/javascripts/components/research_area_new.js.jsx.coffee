{div, form, button, input, label} = React.DOM

class @ResearchAreaNew extends React.Component
  constructor: (props) ->
    super props
    @state =
      uri: ''

  typeaheadFilter: (inputValue, option) ->
    regex = new RegExp(inputValue, 'i')
    option['name'].match(regex) && option['name'] != inputValue

  typeaheadDisplay: (option, index) ->
    @setState(uri: option['id'])
    option['name']

  render: ->
    Typeahead = React.createFactory(window.ReactTypeahead.Typeahead)
    typeaheadClasses = {
      input: 'form-control'
    }
    token = $('meta[name="csrf-token"]').attr('content');
    div {},
      form role: 'form', acceptCharset: 'UTF-8', action: '/admin/research_areas', method: 'post',
        div className: 'form-group',
          label {}, 'Научное направление:'
          Typeahead {
            customClasses: typeaheadClasses,
            options: @props.areas,
            maxVisible: 5,
            filterOption: @typeaheadFilter,
            displayOption: (option, index) => @typeaheadDisplay(option, index),
            placeholder: 'Начните вводить название для поиска',
            customListComponent: window.TypeaheadList},
        div className: 'form-group', style: {display: 'none'},
          label htmlFor: 'research_area_uri', 'URI:'
          input {
            className: 'form-control',
            id: 'research_area_uri',
            value: @state.uri,
            readOnly: true,
            name: 'research_area[uri]'},
        div className: 'form-group', style: {display: 'none'},
          input type: 'hidden', name: 'authenticity_token', value: token,
        div className: 'form-group',
          button type: 'submit', className: 'btn btn-success btn-xs', 'Добавить'
