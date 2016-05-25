import React from 'react'

import NotificationTemplate from './notification_template';
import PreviewButton from './preview_button';
import PreviewOutput from './preview_output';

var Template = React.createClass({
  render: function() {
    const { template, actions, isPreviewing, preview } = this.props;

    var templateOrPreview;
    if (isPreviewing) {
      templateOrPreview = (function(){
        return (
            <PreviewOutput preview={preview} />
        );
      }());
    } else {
      templateOrPreview = (function(){
        return (
            <NotificationTemplate template={template} actions={actions} />
        );
      }());
    }

    return (
        <div id="template_container">
        <PreviewButton isPreviewing={isPreviewing} actions={actions} />
        {templateOrPreview}
        </div>
    );
  }
});

module.exports = Template;
