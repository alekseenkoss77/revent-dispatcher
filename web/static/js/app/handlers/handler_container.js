import axios from "axios"
import React from "react";
import MainMenu from "../menu.js";
import HandlerForm from "./handler_form.js";
import HandlerList from "./handler_list.js";

class HandlerContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      handlers: [],
      editableHandler: null
    };

    this.handleSave = this.handleSave.bind(this);
    this.handleEdit = this.handleEdit.bind(this);
    this.handleDestroy = this.handleDestroy.bind(this);
  }

  componentDidMount() {
    axios
      .get("/api/handlers")
      .catch((e) => (console.log(e)))
      .then(
        (response) => {
          this.setState({
            handlers: response.data.handlers,
            editableEvent: null
          });
        }
      );
  }

  handleSave(e, { formData }) {
    e.preventDefault();
    const handler = this.state.editableHandler;
    var target = e.target;

    if(handler) {
      axios
        .put("/api/handlers/" + handler.id, {"handler" : formData})
        .catch((e) => (console.log(e)))
        .then(
          (response) => {
            let handlers = this.state.handlers;
            handlers[handler.key] = response.data;
            this.setState({
              handlers: handlers,
              editableHandler: null
            });
          }
        );
    } else {
      axios
        .post("/api/handlers", { "handler": formData })
        .catch((e) => (console.log(e)))
        .then(
          (response) => {
            this.setState({
              handlers: this.state.handlers.concat(response.data),
              editableHandler: null
            });
          }
        )
    }
  }

  handleDestroy(id) {

  }

  handleEdit(id) {

  }

  render() {
    return(
      <div>
        <MainMenu />
        <HandlerForm key={ "eventInput" } editableHandler={ this.state.editableEvent } handleSubmit={ this.handleSave } />
        <HandlerList handleDestroy={this.handleDestroy} handleEdit={ this.handleEdit } handlersList={ this.state.handlers } />
      </div>
    );
  }
}

export default HandlerContainer;
