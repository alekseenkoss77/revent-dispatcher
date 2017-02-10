import axios from "axios"
import React from "react";
import { Icon, Table } from "semantic-ui-react";
import EventItem from "./event_item.jsx";

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
            <EventItem key={id} eventName={e.name} />
        ))}
      </Table.Body>
    </Table>
  </div>
);

export default EventList;
