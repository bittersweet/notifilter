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

  decrementOffset: function(event) {
    event.preventDefault();

    const { isPreviewing, actions } = this.props;

    actions.updatePreviewOffset(-1);

    if (isPreviewing) {
      actions.getPreview();
    }
  },

  incrementOffset: function(event) {
    event.preventDefault();

    const { isPreviewing, actions } = this.props;

    actions.updatePreviewOffset(1);

    if (isPreviewing) {
      actions.getPreview();
    }
  },


  render: function() {
    const { isPreviewing, previewOffset } = this.props;

    var text;
    var offsetButtons;
    if (isPreviewing) {
      var nextButton;
      var previousButton;

      nextButton = <a onClick={this.incrementOffset} className="preview-next">Next ❯</a>

      if (previewOffset > 0) {
        previousButton = <a onClick={this.decrementOffset} className="preview-previous">❮ Previous</a>
      }

      offsetButtons = [previousButton, nextButton]
      text = 'Write';
    } else {
      offsetButtons = null;
      text = 'Preview';
    }

    return (
        <div className="preview_buttons">
        <a onClick={this.handleClick} className="preview-button">{text}</a>
        {offsetButtons}
        </div>
    );
  }
});

module.exports = PreviewButton;
