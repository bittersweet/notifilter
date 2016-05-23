import React from 'react';
import Store from './../store';

var PreviewButton = React.createClass({
    handleClick: function(event) {
        event.preventDefault();

        const { actions } = this.props;

        // TODO: refactor
        // needs to grab data from local server and add that
        // For now it's stubbed in actions.js
        const { application, template, eventName } = Store.getState();
        console.log('application:', application, 'template:', template, 'eventName:', eventName);

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
