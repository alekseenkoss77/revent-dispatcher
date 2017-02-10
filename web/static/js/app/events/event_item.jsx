import React from "react";
import { Icon, Table } from "semantic-ui-react";

const EventItem = (props) => (
  <Table.Row>
    <Table.Cell collapsing>
      { props.eventName }
    </Table.Cell>
  </Table.Row>
);

export default EventItem;
