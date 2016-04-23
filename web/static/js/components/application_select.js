import React from 'react';

var ApplicationSelect = React.createClass({
  updateApplication: function(event) {
    event.preventDefault();
    const application = this.refs.application.value;
    const { actions } = this.props;
    actions.updateApplication(application);
  },

  render: function() {
    const { application } = this.props;
    const keys = window.options.applications.map(function(app, i) {
      return (
        <option key={i} value={app}>{app}</option>
      );
    });

    return (
      <div>
      <label htmlFor="application">Application</label>
      <select id="application" ref="application" value={application} onChange={this.updateApplication}>
        {keys}
      </select>
      </div>
    );
  }
});

module.exports = ApplicationSelect;
