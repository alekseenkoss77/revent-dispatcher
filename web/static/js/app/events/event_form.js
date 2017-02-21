import React from "react";
import { Button, Form, Input } from "semantic-ui-react";

class EventForm extends React.Component {
  constructor(props) {
    super(props);
    
    this.state = { eventVal: '' };

    this.handleChange = this.handleChange.bind(this);
  }

  componentWillReceiveProps(newProps) {
    if (newProps.editableEvent) {
      this.setState({ eventVal: (newProps.editableEvent.name) })
    } else {
      this.setState({ eventVal: '' })
    }
  }

  handleChange(event) {
    this.setState({eventVal: event.target.value});
  }

  render() {
    return(
      <div>
        <Form onSubmit={this.props.handleSubmit}>
          <Form.Input label='Name' name='name' placeholder='Name' onChange={ this.handleChange } value={ this.state.eventVal } />
          <Button primary type='submit'>Save</Button>
        </Form>
      </div>
    );
  }
}

export default EventForm;
