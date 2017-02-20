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
          this.setState({handlers: response.data.handlers});
        }
      );
  }

  handlerSave(e, { formData }) {

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
        <HandlerList handleDestroy={this.handleDestroy} handleEdit={ this.handleEdit } eventsList={ this.state.events } />
      </div>
    );
  }
}

export default HandlerContainer;
