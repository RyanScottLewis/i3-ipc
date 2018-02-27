require "socket"
require "../i3"
require "./message"
require "./message/*"
require "./event/*"

class I3::Connection

  def self.get_socket_path
    socket_path   = ENV["I3SOCK"]?
    socket_path ||= ENV["SWAYSOCK"]?
    socket_path ||= `i3 --get-socketpath`.chomp
  end

  def self.connect
    new.connect
  end

  def self.connect(&block : Proc(I3::Connection, Void))
    new.connect(&block)
  end

  def self.connect(path)
    new(path).connect
  end

  def self.connect(path, &block : Proc(I3::Connection, Void))
    new(path).connect(&block)
  end

  property socket      : UNIXSocket?
  property socket_path : String

  def initialize(path = nil)
    @socket_path = path.nil? ? self.class.get_socket_path : path
  end

  def connect(path = nil)
    path ||= @socket_path

    unless @socket.nil?
      I3.logger.warn("Already connected to the socket, reconnecting.")

      @socket.as(UNIXSocket).close
    end

    @socket = UNIXSocket.new(path)

    self
  end

  def connect(path = nil, &block : Proc(I3::Connection, Void))
    connect(path)
    yield(self)
    close

    self
  end

  def close
    return if @socket.nil?

    @socket.as(UNIXSocket).close

    self
  end

  def read(response_type)
    response = Message.from_io(@socket.not_nil!)

    response_type.from_json(response.data)
  end

  def on(&block)
    response = Message.from_io(@socket.not_nil!)
    event    = convert_event(response)

    yield(event)
  end

  def write(request_type, data="")
    request = Message.new(request_type, data)

    request.to_io(@socket.not_nil!)
  end

  def send(request_type, response_type, data="")
    write(request_type, data)
    read(response_type)
  end

  macro def_msg(name, request_type, response_type, var, data)
    def {{name}}{% if var %}({{var}}){% end %}
      send({{request_type}}, {{response_type}}{% if data %}, {{data}}{% end %})
    end
  end

  private alias M  = Message
  private alias MT = Message::Type

  def_msg command,       MT::RUN_COMMAND,       Array(M::Status),    data, data
  def_msg workspaces,    MT::GET_WORKSPACES,    Array(M::Workspace), nil,  nil
  def_msg subscribe,     MT::SUBSCRIBE,         M::Status,           data, data.to_json
  def_msg outputs,       MT::GET_OUTPUTS,       Array(M::Output),    nil,  nil
  def_msg tree,          MT::GET_TREE,          M::Tree,             nil,  nil
  def_msg marks,         MT::GET_MARKS,         Array(String),       nil,  nil
  def_msg bar_ids,       MT::GET_BAR_CONFIG,    Array(String),       nil,  nil
  def_msg bar_config,    MT::GET_BAR_CONFIG,    M::Bar,              data, data
  def_msg version,       MT::GET_VERSION,       M::Version,          nil,  nil
  def_msg binding_modes, MT::GET_BINDING_MODES, Array(String),       nil,  nil
  def_msg config,        MT::GET_CONFIG,        M::Config,           nil,  nil

  def subscribe(event_name : String)
    subscribe([event_name])
  end

  protected def convert_event(response : Message)
    case response.type.as(Event::Type)
    when .workspace?
      Event::Workspace.from_json(response.data)
    when .output?
      Event::Output.from_json(response.data)
    when .mode?
      Event::Mode.from_json(response.data)
    when .window?
      Event::Window.from_json(response.data)
    when .barconfig_update?
      Event::BarConfigUpdate.from_json(response.data)
    when .binding?
      Event::Binding.from_json(response.data)
    when .shutdown?
      Event::Shutdown.from_json(response.data)
    else
      raise Error.new("unknown event message received: #{response}")
    end
  end

end

