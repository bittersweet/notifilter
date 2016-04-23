/*
 * action types
 */

export const ADD_RULE = 'ADD_RULE';
export const REMOVE_RULE = 'REMOVE_RULE';
export const UPDATE_TEMPLATE = 'UPDATE_TEMPLATE';
export const UPDATE_APPLICATION = 'UPDATE_APPLICATION';
export const UPDATE_EVENTNAME = 'UPDATE_EVENTNAME';
export const UPDATE_TARGET = 'UPDATE_TARGET';
// TODO -- figure out how this stuff works, lol.

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
