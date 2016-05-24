import React from 'react';
import store from './../store';

var PreviewButton = React.createClass({
  handleClick: function(event) {
    event.preventDefault();

    const { actions } = this.props;
    const { application, template, eventName } = store.getState();

    actions.getPreview(application, eventName, template);
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
