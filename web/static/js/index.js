import React from 'react';
import ReactDOM from 'react-dom';

import { createStore } from 'redux';
import { Provider } from 'react-redux';
import App from './app';
import store from './store';

let rootElement = document.getElementById('content');
ReactDOM.render(
  <Provider store={store}>
    <App store={store} />
  </Provider>,
  rootElement
);
