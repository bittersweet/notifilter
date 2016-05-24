import React from 'react';

var PreviewButton = React.createClass({
  handleClick: function(event) {
    event.preventDefault();

    const { actions } = this.props;

    actions.getPreview();
  },

  render: function() {
    return (
        <div className="submit">
          <button type="submit" onClick={this.handleClick}>
            Preview
          </button>
        </div>
    );
  }
});

module.exports = PreviewButton;
