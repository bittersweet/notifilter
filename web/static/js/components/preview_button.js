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
      text = 'Edit';
    } else {
      text = 'Preview';
    }

    return (
        <div className="submit">
          <button type="submit" onClick={this.handleClick}>
            {text}
          </button>
        </div>
    );
  }
});

module.exports = PreviewButton;
