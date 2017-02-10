import axios from "axios"
import React from "react";
import MainMenu from "../menu.jsx";
import EventForm from "./event_form.jsx";
import EventList from "./event_list.jsx";

class EventContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      events: [],
      editableItem: {}
    }

    this.handleSave = this.handleSave.bind(this);
  }

  handleSave(e, { formData }) {
    e.preventDefault();

    axios
      .post("/api/events", { "event": formData })
      .catch((e) => (console.log(e)))
      .then(
        (response) => {
          this.setState({
            events: this.state.events.concat(response.data),
            editableItem: {}
          });
        }
      )
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
        <MainMenu />
        <EventForm editableEvent={ this.state.editableItem } handleSubmit={ this.handleSave } />
        <EventList eventsList={ this.state.events } />
      </div>
    );
  }
}

export default EventContainer;
