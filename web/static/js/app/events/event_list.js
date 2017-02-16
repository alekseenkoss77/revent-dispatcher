import React from "react";
import { Icon, Table } from "semantic-ui-react";
import EventItem from "./event_item.js";

const EventList = (props) => (
   <div>
    <Table celled striped>
      <Table.Header>
        <Table.Row>
          <Table.HeaderCell colSpan='3'>Events</Table.HeaderCell>
        </Table.Row>
      </Table.Header>
      <Table.Body>
        { props.eventsList.map((e, id) => (
            <EventItem key={id} eventKey={id} handleEdit={ props.handleEdit } handleDestroy={props.handleDestroy} eventName={e.name} />
        ))}
      </Table.Body>
    </Table>
  </div>
);

export default EventList;
