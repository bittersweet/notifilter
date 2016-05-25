import React from 'react'

var PreviewOutput = React.createClass({
  render: function() {
    const { preview } = this.props;

    return (
        <div id="template_preview">
        { preview }
        </div>
    );
  }
});

module.exports = PreviewOutput;
