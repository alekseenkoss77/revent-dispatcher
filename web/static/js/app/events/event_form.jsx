import React from "react";
import { Button, Form, Input } from "semantic-ui-react";

const EventForm = (props) => {
  let input = null;

  if(props.editableEvent) {
    input = <Form.Input label='Name' name='name' placeholder='Name' />;
  } else {
    input = <Form.Input label='Name' name='name' placeholder='Name' value={ props.editableEvent.name } />;
  }

  return(
    <div>
      <Form onSubmit={props.handleSubmit}>
        <Form.Group widths='equal'>
          { input }
          <Button primary type='submit'>Save</Button>
        </Form.Group>
      </Form>
    </div>
  );
};

export default EventForm;
