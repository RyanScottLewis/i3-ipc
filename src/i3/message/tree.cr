require "json"
require "./rect"

class I3::Message::Tree
  JSON.mapping(
    id:                   Int32,
    name:                 String?,
    type:                 String,
    border:               String,
    current_border_width: Int32,
    layout:               String,
    orientation:          String,
    percent:              Float32?,
    rect:                 Rect,
    window_rect:          Rect,
    deco_rect:            Rect,
    geometry:             Rect,
    window:               Int32?,
    urgent:               Bool,
    focused:              Bool,
    focus:                Array(Int32),
    nodes:                Array(Tree),
    floating_nodes:       Array(Tree),
  )
end
