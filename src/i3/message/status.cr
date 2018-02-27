require "json"

class I3::Message::Status
  JSON.mapping(
    success: Bool,
    error:   String?,
  )
end
