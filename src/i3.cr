require "logger"
require "./i3/connection"

module I3

  @@logger : Logger?

  def self.logger
    @@logger ||= Logger.new(STDOUT)
  end

  def self.connect(&block : Proc(I3::Connection, Void))
    I3::Connection.connect(&block)
  end

  def self.connect(path, &block : Proc(I3::Connection, Void))
    I3::Connection.connect(path, &block)
  end

end

