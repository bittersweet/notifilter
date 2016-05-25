import React from 'react'

var PreviewOutput = React.createClass({
  render: function() {
    const { preview } = this.props;

    return (
        <div>
        { preview }
        </div>
    );
  }
});

module.exports = PreviewOutput;
