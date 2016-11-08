import React from 'react';

require('../css/application.scss');
import { connect } from 'react-redux';

import Template from './components/template';
import DebugOutput from './components/debug_output';
import RuleForm from './components/rule_form';
import AddRule from './components/add_rule';
import SubmitButton from './components/submit_button';
import ApplicationSelect from './components/application_select';
import EventSelect from './components/event_select';
import TargetField from './components/target_field';

import { bindActionCreators } from 'redux';
import * as RuleActions from './actions';

var App = React.createClass({
  render: function() {
    console.log('props:', this.props);
    const { dispatch, rules, application, target, template, eventName, isPreviewing, preview} = this.props;
    const actions = bindActionCreators(RuleActions, dispatch);

    var ruleElements;
    if (Object.keys(rules).length == 0) {
      ruleElements = null;
    } else {
      ruleElements = rules.map(function(rule, i) {
        return (
          <RuleForm key={i} rule={rule} index={i} actions={actions} />
        );
      });
    }

    return (
      <div>
        <ApplicationSelect application={application} actions={actions} />
        <EventSelect eventName={eventName} actions={actions} />
        <TargetField target={target} actions={actions} />
        <Template template={template} actions={actions} isPreviewing={isPreviewing} preview={preview} />
        <div>
            {ruleElements}
            <AddRule actions={actions} />
        </div>
        <SubmitButton actions={actions} />
      </div>
    );
  }
});

function select(state) {
  return state;
}

export default connect(select)(App);
