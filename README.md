# i3-ipc

A Crystal interface for I3 IPC.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  i3-ipc:
    github: RyanScottLewis/i3-ipc
```

## Usage

```crystal
require "i3"
```

See `examples/` directory for more usage examples.

## Reasoning

Inspired by [i3.cr by woodruffw](https://github.com/woodruffw/i3.cr).

While woodruffw's library is excellent, I couldn't figure out how to correctly subscribe to events.  
These two libraries are nearly identical, they just communicate with the unix socket in
fundementally different ways.

## Contributing

1. Fork it ( https://github.com/RyanScottLewis/i3-ipc/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [RyanScottLewis](https://github.com/RyanScottLewis) Ryan Scott Lewis - creator, maintainer
