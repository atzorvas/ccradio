require 'test_helper'

class StreamTest < ActiveSupport::TestCase
  fixtures :streams

  test "stream attributes must not be empty" do
    stream = Stream.new
    assert stream.invalid?
    assert stream.errors[:title].any?
    assert stream.errors[:server].any?
    assert stream.errors[:mount].any?
  end

  test "stream title uniqueness" do
    rock = streams(:rock)
    stream = Stream.new(title: rock.title,
                        server: "http://newserver.com/",
                        mount: "/newmount0"
                        )
    assert stream.invalid?
    assert_equal stream.errors.count, 1
    assert stream.errors[:title]
  end

  test "stream (server, mount) uniqueness" do
    rock = streams(:rock)
    stream = Stream.new(title: "New Genre",
                        server: rock.server,
                        mount: rock.mount
                        )
    assert stream.invalid?
    assert stream.errors[:mount].any?
  end

  test "stream playlist history populated correctly" do
    assert_equal streams(:rock).playlist_items.count, 2
  end

  test "should not insert in the playlist the same song twice in a row" do
    stream = streams(:jazz)
    assert_difference 'stream.playlist_items.count' do
      stream.playlist_items.create(song: "Jazz Song")
    end
    playlist_item = stream.playlist_items.build(song: "Jazz Song")
    assert playlist_item.invalid?
  end

  test "should allow same song twice in a playlist, if not in a row" do
    stream = streams(:rock)
    assert_equal stream.playlist_items.count, 2
    playlist_item = stream.playlist_items.build(
      song: stream.playlist_items.first
    )
    assert playlist_item.valid?
  end

  test "sync_playlists does work" do
    assert_difference 'PlaylistItem.count' do
      Stream.sync_playlists
    end
  end
end
