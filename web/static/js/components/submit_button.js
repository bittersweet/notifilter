import React from 'react';

var SubmitButton = React.createClass({
  getInitialState: function() {
    return {
      loading: false
    };
  },

  handleClick: function(event) {
    event.preventDefault();

    const { actions } = this.props;
    console.log('test');

    actions.persistNotifier();
  },

  render: function() {
    const { loading } = this.props;
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
