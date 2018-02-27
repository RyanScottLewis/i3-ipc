require "json"

class I3::Event::Shutdown
  JSON.mapping(
    change: String,
  )
end
