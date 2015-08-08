# Seed Streams
streams = {
  0 => "Everything",
  1 => "Alternative",
  2 => "Electronic",
  3 => "Jazz",
  4 => "Pop",
  5 => "Rock",
  6 => "Jazz + Electronic",
  7 => "Jazz + Rock",
  8 => "Electronic + Pop",
  9 => "Rock + Alternative"
}

streams.each do |mountId, title|
  Stream.create!(title: title,
                 mount: "/live#{mountId}",
                 server: "http://stream.creativecommons.gr:8000/")
end
