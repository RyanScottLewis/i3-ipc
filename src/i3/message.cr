require "./error"

class I3::Message; end

require "./message/type"
require "./event/type"

class I3::Message

  HEADER = "i3-ipc"

  def self.from_io(io)
    header = io.gets(HEADER.size)
    raise(Error::InvalidMessageHeader.new) unless header == HEADER

    size = io.read_bytes(Int32)
    type = io.read_bytes(Int32)
    data = io.gets(size)
    type = (type >> 31).zero? ? Message::Type.new(type) : Event::Type.new(type & 0x7F)

    raise(Error::InvalidMessageData.new) if data.nil?
    raise(Error::InvalidMessageSize.new) unless size == data.bytes.size

    new(type, data, size)
  end

  property size : Int32
  property type : Message::Type | Event::Type
  property data : String

  def initialize(@type, @data = "", size = nil)
    @size = size.nil? ? @data.size : size
  end

  def to_io(io)
    io << HEADER
    io.write_bytes(@size)
    io.write_bytes(@type.to_i)
    io << @data
  end

end
