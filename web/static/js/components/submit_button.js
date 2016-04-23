import React from 'react';

import fetch from 'isomorphic-fetch';

// TODO: Find out best way to receive this from parent for better data flow
import store from './../store';

var SubmitButton = React.createClass({
  getInitialState: function() {
    return {
      loading: false,
    }
  },

  handleClick: function(event) {
    event.preventDefault();
    this.setState({ loading: true });

    const { application, eventName, target, template, rules } = store.getState();

    var id = window.notifier.id;
    var jsonMethod ;
    if (id) {
      var url = `/notifiers/${id}`;
      jsonMethod = 'PATCH';
    } else {
      // Not persisted yet
      var url = `/notifiers`;
      jsonMethod = 'POST';
    }
    fetch(url, {
      method: jsonMethod,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        notifier: {
          application: application,
          event_name: eventName,
          target: target,
          template: template,
          rules: rules,
        }
      })
    })
      .then(() => {
        this.setState({ loading: false });
      })
      .catch(exception => {
        console.log('POST failed:', exception)
        this.setState({ loading: false });
      })
  },

  render: function() {
    const { loading } = this.state;
    let text = 'Submit';
    if (loading) {
      text = 'Loading...';
    }
    return (
      <div className="submit">
        <button type="submit" onClick={this.handleClick} disabled={loading} >
          {text}
        </button>
      </div>
    );
  }
});

module.exports = SubmitButton;
