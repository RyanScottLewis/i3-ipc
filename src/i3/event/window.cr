require "json"
require "../message/tree"

class I3::Event::Window
  JSON.mapping(
    change:    String,
    container: Message::Tree,
  )
end
