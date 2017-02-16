import axios from "axios"
import React from "react";
import MainMenu from "../menu.js";
import HandlerForm from "./handler_form.js";
import HandlerList from "./handler_list.js";

class HandlerContainer extends React.Component {
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
      );
  }
}

export default HandlerContainer;
