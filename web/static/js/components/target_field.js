import React from 'react';

var TargetField = React.createClass({
  updateTarget: function(event) {
    event.preventDefault();
    const target = this.refs.target.value;
    const { actions } = this.props;
    actions.updateTarget(target)
  },

  render: function() {
    const { target } = this.props;

    return (
      <div>
        <label htmlFor="target">Target:</label>
        <input type="text" id="target" ref="target" value={target} onChange={this.updateTarget} />
      </div>
    );
  }
});

module.exports = TargetField;
