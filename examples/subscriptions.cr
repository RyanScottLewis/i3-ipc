require "../src/i3"

I3.connect do |connection|
  puts "", "connection.subscribe ".ljust(120, '-'), ""
  #p connection.subscribe("window")
  p connection.subscribe(["workspace", "output", "mode", "window", "barconfig_update", "binding", "shutdown"])

  count = 0
  while count < 5
    connection.on do |event|
      p event
      puts "!" * 80
    end
  end
end

