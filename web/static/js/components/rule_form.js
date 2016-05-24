import React from 'react';

import RemoveRule from './remove_rule';
import store from './../store';

var RuleForm = React.createClass({
  handleChange: function(event) {
    event.preventDefault();

    var rule = {
      key: this.refs.key.value,
      type: this.refs.type.value,
      setting: this.refs.setting.value,
      value: this.refs.value.value
    };
    // TODO -- simplify via actions.js
    store.dispatch({ type: 'UPDATE_RULE', index: this.props.index, rule: rule });
  },

  render: function() {
    const { key, type, setting, value } = this.props.rule;

    var keys = window.options.keys.map(function(key, i) {
      return (
        <option key={i} value={key}>{key}</option>
      );
    });

    return (
      <div className="rule">
        <RemoveRule index={this.props.index} actions={this.props.actions} />

        <select ref="key" value={key} onChange={this.handleChange}>
          {keys}
        </select>

        <select ref="type" value={type} onChange={this.handleChange}>
          <option value="boolean">boolean</option>
          <option value="string">string</option>
          <option value="number">number</option>
        </select>

        <select ref="setting" value={setting} onChange={this.handleChange}>
          <option value=""></option>
          <option value="eq">eq</option>
          <option value="gt">gt</option>
          <option value="lt">lt</option>
          <option value="noteq">noteq</option>
        </select>

        <input type="text" ref="value" value={value} onChange={this.handleChange} placeholder="Value" />
      </div>
    );
  }
});

module.exports = RuleForm;
