class @Project extends React.Component
  @propTypes =
    id: React.PropTypes.number
    title: React.PropTypes.string
    description: React.PropTypes.string

  render: ->
    `<div className='panel panel-default'>
      <div className='panel-body'>
        <h4>
          <a href={'/projects/' + this.props.id}>{this.props.title}</a>
        </h4>
        <div className='col-md-12 text-justify'>
          <div dangerouslySetInnerHTML={{__html: this.props.description}}>
          </div>
          <a href={'/projects/' + this.props.id}> Читать далее</a>
        </div>
      </div>
    </div>`
