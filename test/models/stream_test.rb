require 'test_helper'

class StreamTest < ActiveSupport::TestCase
  fixtures :streams

  test 'stream attributes must not be empty' do
    stream = Stream.new
    assert stream.invalid?
    assert stream.errors[:title].any?
    assert stream.errors[:server].any?
    assert stream.errors[:mount].any?
  end

  test 'stream title uniqueness' do
    rock = streams(:rock)
    stream = Stream.new(
      title: rock.title,
      server: "http://newserver.com/",
      mount: "/newmount0"
    )
    assert stream.invalid?
    assert_equal stream.errors.count, 1
    assert stream.errors[:title]
  end

  test 'stream (server, mount) uniqueness' do
    rock = streams(:rock)
    stream = Stream.new(
      title: 'New Genre',
      server: rock.server,
      mount: rock.mount
    )
    assert stream.invalid?
    assert stream.errors[:mount].any?
  end

  test 'stream playlist history populated correctly' do
    assert_equal streams(:rock).playlist_items.count, 2
  end

  test 'should not insert in the playlist the same song twice in a row' do
    stream = streams(:jazz)
    assert_difference 'stream.playlist_items.count' do
      stream.playlist_items.create(song: 'Jazz Song')
    end
    playlist_item = stream.playlist_items.build(song: 'Jazz Song')
    assert playlist_item.invalid?
  end

  test 'should allow same song twice in a playlist, if not in a row' do
    stream = streams(:rock)
    assert_equal stream.playlist_items.count, 2
    playlist_item = stream.playlist_items.build(
      song: stream.playlist_items.first
    )
    assert playlist_item.valid?
  end

  test 'should return only enabled streams' do
    assert_equal Stream.enabled.count, 3
  end

  test 'sync_playlists calls sync_latest_song for each item' do
    stream = Minitest::Mock.new
    stream.expect :sync_latest_song, nil

    Stream.stub :enabled, [stream] do
      assert Stream.enabled.count, 1
      Stream.sync_playlists
    end
  end

  test 'sync_latest_item gets a song' do
    VCR.use_cassette('get_latest_song_rock') do
      assert_difference 'PlaylistItem.count' do
        streams(:rock).send(:sync_latest_song)
      end
    end
  end
end
