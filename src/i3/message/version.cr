class I3::Message::Version
  JSON.mapping(
    major:                   Int32,
    minor:                   Int32,
    patch:                   Int32,
    human_readable:          String,
    loaded_config_file_name: String,
  )
end
