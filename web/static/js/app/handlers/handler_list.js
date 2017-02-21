import axios from "axios";
import React from "react";
import MainMenu from "../menu.js";
import { Icon, Table } from 'semantic-ui-react'

import HandlerItem from "./handler_item.js"

const HandlerList = (props) => (
  <div>
    <Table celled striped>
      <Table.Header>
        <Table.Row>
          <Table.HeaderCell colSpan='3'>Handlers</Table.HeaderCell>
        </Table.Row>
      </Table.Header>
      <Table.Body>
        { props.handlersList.map((h, id) => (
          <HandlerItem key={id} handlerName={h.name} handlerQueueName={h.queue_name} />
        ))}
      </Table.Body>
    </Table>
  </div>
);

export default HandlerList;
