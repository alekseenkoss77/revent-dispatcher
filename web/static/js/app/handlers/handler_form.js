import axios from "axios";
import React from "react";
import { Button, Form, Input } from "semantic-ui-react";

class HandlerForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = { queue_name: '', name: '', selectedItems: [], events: [] };

    this.handleChange = this.handleChange.bind(this);
    this.handleSelect = this.handleSelect.bind(this);
  }

  componentWillReceiveProps(newProps) {
    if (newProps.editableHandler) {
      this.setState({
        name: newProps.editableHandler.name,
        queue_name: newProps.editableHandler.queue_name,
        selectedItems: newProps.editableHandler.events.map((e) => (e.id))
      });
    } else {
      this.setState({
        name: '',
        queue_name: '',
        selectedItems: []
      });
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
      );
  }

  handleChange(event) {
    const target = event.target;
    const name = target.name;
    const value = target.value;

    this.setState({
      [name]: value
    });
  }

  handleSelect(event) {
    const target = event.target;
    const checked = target.checked;
    const value = Number.parseInt(target.value);

    let selected = this.state.selectedItems;

    if(checked) {
      selected.push(value);
      this.setState({ selectedItems: selected });
    } else {
      const i = selected.indexOf(value);
      
      if(i != -1) {
        selected.splice(i, 1);
      };
      this.setState({ selectedItems: selected });
    }
  }

  render() {
    return(
      <div>
        <Form onSubmit={this.props.handleSubmit}>
          <Form.Group widths='equal'>
            <Form.Input label='Name' name='name' placeholder='Name' onChange={ this.handleChange } value={ this.state.name } />
            <Form.Input label='Queue' name='queue_name' placeholder='Queue name' onChange={ this.handleChange } value={ this.state.queue_name } />
          </Form.Group>
          <Form.Group grouped>
            { this.state.events.map((e, index) => (
                <Form.Field
                  key={e.id}
                  label={e.name}
                  value={e.id}
                  name='events'
                  checked={ this.state.selectedItems.includes(e.id) }
                  control='input'
                  onChange={ this.handleSelect }
                  type='checkbox'
                />
              ))
            }
          </Form.Group>
          <Button primary type='submit'>Save</Button>
        </Form>
      </div>
    );
  }
}

export default HandlerForm;
