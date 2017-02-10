import React from 'react';

import MainPage from "./pages/main.jsx";
import EventContainer from "./events/event_container.jsx";
import HandlerList from "./handlers/handler_list.jsx";
import { Router, Route, Link, browserHistory } from 'react-router'

const App = () => (
  <Router history={browserHistory}>
    <Route path="/" component={MainPage} />
    <Route path="/events" component={EventContainer} />
    <Route path="/handlers" component={HandlerList} />
    <Route path="/*" component={EventContainer} />
  </Router>
);

export default App;
