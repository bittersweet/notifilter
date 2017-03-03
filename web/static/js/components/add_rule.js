import React from 'react';

var AddRule = React.createClass({
  render: function() {
    const { actions } = this.props;
    return (
      <button id="add_rule" href='#' onClick={e => {
        e.preventDefault();
        actions.addRule();
      }}>
        Add rule
      </button>
    );
  }
});

module.exports = AddRule;
