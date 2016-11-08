import React from 'react';

var PreviewButton = React.createClass({
  handleClick: function(event) {
    event.preventDefault();

    const { isPreviewing, actions } = this.props;

    if (isPreviewing) {
      actions.updatePreviewing(false);
    } else {
      actions.getPreview();
    }
  },

  render: function() {
    const { isPreviewing } = this.props;

    var text;
    if (isPreviewing) {
      text = 'Write';
    } else {
      text = 'Preview';
    }

    return (
        <div className="preview_buttons">
        <a onClick={this.handleClick}>{text}</a>
        </div>
    );
  }
});

module.exports = PreviewButton;
