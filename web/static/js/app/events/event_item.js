import React from "react";
import { Icon, Table, Button } from "semantic-ui-react";

const EventItem = (props) => (
  <Table.Row>
    <Table.Cell collapsing>
      { props.eventName }
    </Table.Cell>
    <Table.Cell textAlign='right'>
      <Button icon onClick={ () => props.handleEdit(props.eventKey) }>
        <Icon name='edit' color='grey' />
      </Button>
      <Button icon onClick={ () => props.handleDestroy(props.eventKey) }>
        <Icon name='delete' color='red' />
      </Button>
    </Table.Cell>
  </Table.Row>
);

export default EventItem;
