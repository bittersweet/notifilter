import React from 'react';

var NotificationTemplate = React.createClass({
  handleChange: function(event) {
    event.preventDefault();
    const template = this.refs.template.value;
    const { actions } = this.props;
    actions.updateTemplate(template);
  },

  render: function() {
    const { template } = this.props;

    return (
      <div>
        <label htmlFor="template">Template</label>
        <textarea id="template" value={template} rows="5" ref="template" onChange={this.handleChange}>
        </textarea>
      </div>
    );
  }
});

module.exports = NotificationTemplate;
