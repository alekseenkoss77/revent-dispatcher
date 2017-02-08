import axios from "axios"
import React from "react";
import Menu from "../menu.jsx";
import EventItem from "./event_item.jsx"

class EventList extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      events: []
    }
  }

  componentDidMount() {
    axios
      .get("/api/events")
      .catch((e) => (console.log(e)))
      .then(
        (response) => {
          this.setState({events: response.data.events});
        }
      )
  }

  render() {
    return(
      <div>
        <h3>Events</h3>
        <Menu />
        <ul>
          { this.state.events.map((e, id) => (
              <EventItem key={id} eventName={e.name} />
          ))}
        </ul>
      </div>
    );
  }
}

export default EventList;
