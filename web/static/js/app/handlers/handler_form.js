import React from "react";
import { Button, Form, Input } from "semantic-ui-react";

class HandlerForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = { queue_name: '', name: '' };

    this.handleChange = this.handleChange.bind(this);
  }

  componentWillReceiveProps(newProps) {
    if (newProps.editableHandler) {
      this.setState({
        name: newProps.editableHandler.name,
        queue_name: newProps.editableHandler.queue_name
      });
    } else {
      this.setState({
        name: '',
        queue_name: ''
      });
    }
  }

  handleChange(event) {
    const target = event.target;
    const name = target.name;
    const value = target.value;

    this.setState({
      [name]: value
    });
  }

  render() {
    return(
      <div>
        <Form onSubmit={this.props.handleSubmit}>
          <Form.Group widths='equal'>
            <Form.Input label='Name' name='name' placeholder='Name' onChange={ this.handleChange } value={ this.state.name } />
            <Form.Input label='Queue' name='queue_name' placeholder='Queue name' onChange={ this.handleChange } value={ this.state.queue_name } />
          </Form.Group>
          <Button primary type='submit'>Save</Button>
        </Form>
      </div>
    );
  }
}

export default HandlerForm;
