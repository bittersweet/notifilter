import React from 'react';

import store from './../store';

var DebugOutput = React.createClass({
  render: function() {
    var rules = this.props.rules;
    var text = JSON.stringify(rules, null, 2);
    return (
      <div>
        <textarea readOnly={'true'} rows="15" cols="60" value={text} />
      </div>
    );
  }
});

module.exports = DebugOutput;
