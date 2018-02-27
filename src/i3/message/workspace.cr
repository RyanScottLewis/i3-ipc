require "json"
require "./rect"

class I3::Message::Workspace
  JSON.mapping(
    num:     Int32,
    name:    String,
    visible: Bool,
    focused: Bool,
    urgent:  Bool,
    rect:    Rect,
    output:  String,
  )
end
