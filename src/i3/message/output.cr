require "json"
require "./rect"

class I3::Message::Output
  JSON.mapping(
    name:              String,
    active:            Bool,
    primary:           Bool,
    current_workspace: String?,
    rect:              Rect,
  )
end
