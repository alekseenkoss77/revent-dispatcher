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
      events: [],
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
            editableHandler: null
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
        .put("/api/handlers/" + handler.id, {"handler": formData})
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
    let item = this.state.handlers[id];
    var _this = this

    axios
      .delete("/api/handlers/" + item.id)
      .catch((e) => (console.log(e)))
      .then(
        (response) => {
          let _handlers = _this.state.handlers
          _handlers.splice(id, 1)
          _this.setState({
            handlers: _handlers
          });
        }
      );

  }

  handleEdit(id) {
    let item = this.state.handlers[id];

    this.setState({
      editableHandler: Object.assign(item, { key: id })
    })
  }

  render() {
    return(
      <div>
        <MainMenu />
        <HandlerForm key={ "eventInput" } events={this.state.events} editableHandler={ this.state.editableHandler } handleSubmit={ this.handleSave } />
        <HandlerList handleDestroy={this.handleDestroy} handleEdit={ this.handleEdit } handlersList={ this.state.handlers } />
      </div>
    );
  }
}

export default HandlerContainer;
