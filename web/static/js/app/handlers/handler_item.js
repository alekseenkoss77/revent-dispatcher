import React from "react";
import { Icon, Table, Label, Button } from "semantic-ui-react";

const HandlerItem = (props) => (
  <Table.Row>
    <Table.Cell collapsing>
      { props.handlerName }
    </Table.Cell>
    <Table.Cell collapsing>
      { props.handlerQueueName }
    </Table.Cell>
    <Table.Cell>
      { props.handlerEvents.map((e, id) => (<Label key={id}><Label.Detail>{ e.name }</Label.Detail></Label>)) }
    </Table.Cell>
    <Table.Cell textAlign='right' collapsing>
      <Button icon onClick={ () => props.handleEdit(props.handlerKey) }>
        <Icon name='edit' color='grey' />
      </Button>
      <Button icon onClick={ () => props.handleDestroy(props.handlerKey) }>
        <Icon name='delete' color='red' />
      </Button>
    </Table.Cell>
  </Table.Row>
);

export default HandlerItem;
