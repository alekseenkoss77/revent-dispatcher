import React from 'react';
import { Link } from 'react-router';
import { Menu } from 'semantic-ui-react';

const MainMenu = () => (
  <div>
    <Menu pointing secondary>
      <Link to="/events">
        <Menu.Item name='Events' />
      </Link>
      <Link to="/handlers">
        <Menu.Item name='Handlers' />
      </Link>
    </Menu>
  </div>
);

export default MainMenu;
