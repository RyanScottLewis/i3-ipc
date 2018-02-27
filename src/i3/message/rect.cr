require "json"

class I3::Message::Rect
  JSON.mapping(
    x:      Int32,
    y:      Int32,
    width:  Int32,
    height: Int32,
  )
end
