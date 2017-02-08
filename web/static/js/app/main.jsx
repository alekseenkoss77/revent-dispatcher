import React from 'react';

import MainPage from "./pages/main.jsx";
import EventList from "./events/event_list.jsx";
import HandlerList from "./handlers/handler_list.jsx";
import { Router, Route, Link, browserHistory } from 'react-router'

const App = () => (
  <Router history={browserHistory}>
    <Route path="/" component={MainPage} />
    <Route path="/events" component={EventList} />
    <Route path="/handlers" component={HandlerList} />
  </Router>
);

export default App;
