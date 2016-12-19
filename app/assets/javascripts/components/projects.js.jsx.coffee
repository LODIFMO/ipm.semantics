class @Projects extends React.Component
  render: ->
    `<div className='container'>
      {this.props.projects.map(function(row, i) {
        return(
          <Project key={i} id={row.id} title={row.title} description={row.short_description} />
        );
      })}
    </div>`
