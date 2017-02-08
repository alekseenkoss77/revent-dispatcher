import axios from "axios";
import React from "react";
import Menu from "../menu.jsx";
import { Icon, Table } from 'semantic-ui-react'

import HandlerItem from "./handler_item.jsx"

class HandlerList extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      handlers: []
    }
  }

  componentDidMount() {
    axios
      .get("/api/handlers")
      .catch((e) => (console.log(e)))
      .then(
        (response) => {
          this.setState({handlers: response.data.handlers});
        }
      )
  }

  render() {
    return(
      <div>
        <Menu />

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
