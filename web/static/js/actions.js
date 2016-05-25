/*
 * action types
 */

export const ADD_RULE = 'ADD_RULE';
export const REMOVE_RULE = 'REMOVE_RULE';
export const UPDATE_TEMPLATE = 'UPDATE_TEMPLATE';
export const UPDATE_APPLICATION = 'UPDATE_APPLICATION';
export const UPDATE_EVENTNAME = 'UPDATE_EVENTNAME';
export const UPDATE_TARGET = 'UPDATE_TARGET';
export const UPDATE_PREVIEW_TEMPLATE = 'UPDATE_PREVIEW_TEMPLATE';
export const UPDATE_LOADING = 'UPDATE_LOADING';

/*
 * action creators
 */

export function addRule() {
  return { type: ADD_RULE };
}

export function removeRule(index) {
  return { type: REMOVE_RULE, index: index };
}

export function updateTemplate(template) {
  return { type: UPDATE_TEMPLATE, template: template };
}

export function updateApplication(application) {
  return { type: UPDATE_APPLICATION, application: application };
}

export function updateEventName(eventName) {
  return { type: UPDATE_EVENTNAME, eventName: eventName };
}

export function updateTarget(target) {
  return { type: UPDATE_TARGET, target: target };
}

export function updatePreviewTemplate(preview) {
  return { type: UPDATE_PREVIEW_TEMPLATE, preview: preview };
}

export function updateLoading(loading) {
  return { type: UPDATE_LOADING, loading: loading };
}

export function getPreview() {
  return function(dispatch, getState) {
    const { application, eventName, template } = getState();

    const payload = JSON.stringify({
      application: application,
      event: eventName,
      template: template
    });

    fetch('/preview', {
      method: 'post',
      credentials: 'same-origin',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: payload
    })
      .then(response => response.json())
      .then(json => {
        dispatch(updatePreviewTemplate(json.result));
      })
      .catch(exception => {
        dispatch(updatePreviewTemplate(exception));
      });
  };

}

export function persistNotifier() {
  return (dispatch, getState) => {
    const { application, eventName, target, template, rules } = getState();

    // Indicate we are doing async work
    dispatch(updateLoading(true));

    // TODO: Get rid of this global
    const id = window.notifier.id;
    var url, method;

    const payload = JSON.stringify({
      notifier: {
        application: application,
        event_name: eventName,
        target: target,
        template: template,
        rules: rules
      }
    });

    if (id) {
      url = `/notifiers/${id}`;
      method = 'PATCH';
    } else {
      // Not persisted yet
      url = '/notifiers';
      method = 'POST';
    }

    fetch(url, {
      method: method,
      credentials: 'same-origin',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: payload
    })
      .then(() => {
        dispatch(updateLoading(false));
      })
      .catch(exception => {
        dispatch(updateLoading(false));
      });
  };
}
