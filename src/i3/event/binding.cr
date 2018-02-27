require "json"

class I3::Event::Binding
  class Metadata
    JSON.mapping(
      command:          String,
      event_state_mask: Array(String),
      input_code:       Int32,
      symbol:           String?,
      input_type:       String,
    )
  end

  JSON.mapping(
    change:  String,
    binding: Metadata,
  )
end
