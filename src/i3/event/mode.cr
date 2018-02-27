require "json"

class I3::Event::Mode
  JSON.mapping(
    change:       String,
    pango_markup: Bool,
  )
end
