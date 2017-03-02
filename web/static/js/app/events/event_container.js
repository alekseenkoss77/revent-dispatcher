import axios from "axios"
import React from "react";
import MainMenu from "../menu.js";
import EventForm from "./event_form.js";
import EventList from "./event_list.js";

class EventContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      events: [],
      editableEvent: null
    }

    this.handleSave = this.handleSave.bind(this);
    this.handleEdit = this.handleEdit.bind(this);
    this.handleDestroy = this.handleDestroy.bind(this);
  }

  handleSave(e, { formData }) {
    e.preventDefault();

    const event = this.state.editableEvent;
    var event_target = e.target;

    if(event) {
      axios
        .put("/api/events/" + event.id, {"event" : formData})
        .catch((e) => (console.log(e)))
        .then(
          (response) => {
            let events = this.state.events;
            events[event.key] = response.data;
            this.setState({
              events: events,
              editableEvent: null
            });
          }
        );
    } else {
      axios
        .post("/api/events", { "event": formData })
        .catch((e) => (console.log(e)))
        .then(
          (response) => {
            this.setState({
              events: this.state.events.concat(response.data),
              editableEvent: null
            });
          }
        )
    }
  }

  handleEdit(id) {
    let item = this.state.events[id];

    this.setState({
      editableEvent: Object.assign(item, { key: id })
    })
  }

  handleDestroy(id) {
    let item = this.state.events[id];
    var _this = this

    axios
      .delete("/api/events/" + item.id)
      .catch((e) => (console.log(e)))
      .then(
        (response) => {
          let _events = _this.state.events
          _events.splice(id, 1)
          _this.setState({
            events: _events
          });
        }
      );
  }

  componentDidMount() {
    axios
      .get("/api/events")
      .catch((e) => (console.log(e)))
      .then(
        (response) => {
          this.setState({
            events: response.data.events,
            editableEvent: null
          });
        }
      )
  }

  render() {
    return(
      <div>
        <MainMenu />
        <EventForm key={ "eventInput" } editableEvent={ this.state.editableEvent } handleSubmit={ this.handleSave } />
        <EventList handleDestroy={this.handleDestroy} handleEdit={ this.handleEdit } eventsList={ this.state.events } />
      </div>
    );
  }
}

export default EventContainer;
