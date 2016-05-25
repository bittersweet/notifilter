import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';

function notifier(state = {template: 'templ', rules: []}, action) {
  switch (action.type) {
    case 'UPDATE_RULE': {
      return Object.assign({}, state, {
        rules: [...state.rules.slice(0, action.index),
                Object.assign({}, state.rules[action.index], action.rule),
                ...state.rules.slice(action.index + 1)
               ]
      });
    }

    case 'ADD_RULE': {
      const defaultRule = {
        key: '',
        type: '',
        setting: '',
        value: ''
      };
      return Object.assign({}, state, {
        rules: [...state.rules, defaultRule]
      });
    }

    case 'REMOVE_RULE': {
      return Object.assign({}, state, {
        rules: [...state.rules.slice(0, action.index),
                ...state.rules.slice(action.index + 1)
               ]
      });
    }

    case 'UPDATE_TEMPLATE': {
      return Object.assign({}, state, {
        template: action.template
      });
    }

    case 'UPDATE_APPLICATION': {
      return Object.assign({}, state, {
        application: action.application
      });
    }

    case 'UPDATE_EVENTNAME': {
      return Object.assign({}, state, {
        eventName: action.eventName
      });
    }

    case 'UPDATE_TARGET': {
      return Object.assign({}, state, {
        target: action.target
      });
    }

    case 'UPDATE_PREVIEWING': {
      return Object.assign({}, state, {
        isPreviewing: action.isPreviewing
      });
    }

    case 'UPDATE_PREVIEW_TEMPLATE': {
      return Object.assign({}, state, {
        preview: action.preview
      });
    }

    case 'UPDATE_LOADING': {
      return Object.assign({}, state, {
        loading: action.loading
      });
    }

    default: {
      // If we have an unpersisted record, set up some defaults
      if (state.id === null) {
        // TODO - remove window global usage here
        return Object.assign({}, state, {
          application: window.options.applications[0],
          eventName: window.options.eventNames[0],
        });
      }
      return Object.assign({}, state, {
        isPreviewing: false,
        preview: ''
      });
    }
  }
}

let store = applyMiddleware(thunk)(createStore)(notifier, window.notifier);
store.subscribe(() =>
  console.log('subscribe', store.getState())
);

module.exports = store;
