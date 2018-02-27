require "json"
require "../message/tree"

class I3::Event::Workspace
  JSON.mapping(
    change:  String,
    current: Message::Tree?,
    old:     Message::Tree?,
  )
end
