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
          <Table.HeaderCell colSpan='4'>Handlers</Table.HeaderCell>
        </Table.Row>
      </Table.Header>
      <Table.Body>
        { props.handlersList.map((h, id) => (
          <HandlerItem
            key={id}
            handlerKey={id}
            handlerName={h.name}
            handlerQueueName={h.queue_name}
            handleEdit={ props.handleEdit }
            handleDestroy={props.handleDestroy}
            handlerEvents={h.events} />
        ))}
      </Table.Body>
    </Table>
  </div>
);

export default HandlerList;
