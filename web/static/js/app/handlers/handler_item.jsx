import React from "react";
import { Icon, Table } from 'semantic-ui-react'

const HandlerItem = (props) => (
  <Table.Row>
    <Table.Cell collapsing>
      { props.handlerName }
    </Table.Cell>
    <Table.Cell>{ props.handlerQueueName }</Table.Cell>
  </Table.Row>
);

export default HandlerItem;
