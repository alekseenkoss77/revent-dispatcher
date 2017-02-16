import axios from "axios";
import React from "react";
import MainMenu from "../menu.js";
import { Icon, Table } from 'semantic-ui-react'

import HandlerItem from "./handler_item.js"

class HandlerList extends React.Component {


  render() {
    return(
      <div>
        <MainMenu />

        <Table celled striped>
          <Table.Header>
            <Table.Row>
              <Table.HeaderCell colSpan='3'>Handlers</Table.HeaderCell>
            </Table.Row>
          </Table.Header>
          <Table.Body>
            { this.state.handlers.map((h, id) => (
              <HandlerItem key={id} handlerName={h.name} handlerQueueName={h.queue_name} />
            ))}
          </Table.Body>
        </Table>
      </div>
    );
  }
}

export default HandlerList;
