import React from 'react';

var EventSelect = React.createClass({
  updateEvent: function(event) {
    event.preventDefault();
    const eventName = this.refs.eventName.value;
    const { actions } = this.props;
    actions.updateEventName(eventName);
  },

  render: function() {
    const { eventName } = this.props;
    const eventNames = window.options.eventNames.map(function(eventName, i) {
      return (
        <option key={i} value={eventName}>{eventName}</option>
      );
    });

    return (
      <div>
        <label htmlFor="event_name">Event Name</label>
        <select id="event_name" ref="eventName" value={eventName} onChange={this.updateEvent}>
          {eventNames}
        </select>
      </div>
    );
  }
});

module.exports = EventSelect;
