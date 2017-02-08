import React from "react";

const EventItem = (props) => (
  <div className="Event_item">
    <li>
      <div>{ props.eventName }</div>
    </li>
  </div>
);

export default EventItem;
