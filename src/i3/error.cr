class I3::Error < Exception
  class InvalidMessageHeader < Error; end
  class InvalidMessageSize < Error; end
  class InvalidMessageData < Error; end
end
