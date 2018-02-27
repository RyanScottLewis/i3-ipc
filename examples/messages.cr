require "../src/i3"

I3.connect do |connection|
  puts "", "connection ".ljust(120, '-'), ""
  p connection

  puts "", "connection.workspaces ".ljust(120, '-'), ""
  p connection.workspaces

  puts "", "connection.outputs ".ljust(120, '-'), ""
  p connection.outputs

  puts "", "connection.tree ".ljust(120, '-'), ""
  p connection.tree

  puts "", "connection.marks ".ljust(120, '-'), ""
  p connection.marks

  #puts "", "connection.bar_config ".ljust(120, '-'), ""
  #p connection.bar_config(1)

  puts "", "connection.version ".ljust(120, '-'), ""
  p connection.version

  puts "", "connection.binding_modes ".ljust(120, '-'), ""
  p connection.binding_modes

  puts "", "connection.config ".ljust(120, '-'), ""
  p connection.config
end
