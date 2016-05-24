import React from 'react';

var DebugOutput = React.createClass({
  render: function() {
    const { rules, preview } = this.props;
    var text;
    if (rules) {
      text = JSON.stringify(rules, null, 2);
    } else {
      text = preview;
    }

    return (
      <div>
        <textarea readOnly={'true'} rows="15" cols="60" value={text} />
      </div>
    );
  }
});

module.exports = DebugOutput;
