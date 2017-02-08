import React from 'react';
import { Link } from 'react-router'

const Menu = () => (
  <div>
    <ul>
      <li><Link to="/events">Events</Link></li>
      <li><Link to="/handlers">Handlers</Link></li>
    </ul>
  </div>
);

export default Menu;
