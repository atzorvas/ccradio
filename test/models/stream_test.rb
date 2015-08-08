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
end
