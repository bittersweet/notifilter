import React from 'react';

var RemoveRule = React.createClass({
  render: function() {
    const { actions, index } = this.props;
    return (
      <button className="removeRule" href='#' onClick={e => {
        e.preventDefault();
        actions.removeRule(index);
      }}>
        x
      </button>
    );
  }
});

module.exports = RemoveRule;
