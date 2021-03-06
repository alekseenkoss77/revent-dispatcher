import React from 'react';

import MainPage from "./pages/main.js";
import EventContainer from "./events/event_container.js";
import HandlerContainer from "./handlers/handler_container.js";
import { Router, Route, Link, browserHistory } from 'react-router'

const App = () => (
  <Router history={browserHistory}>
    <Route path="/" component={EventContainer} />
    <Route path="/events" component={EventContainer} />
    <Route path="/handlers" component={HandlerContainer} />
  </Router>
);

export default App;
