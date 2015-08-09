require 'test_helper'

class StreamsControllerTest < ActionController::TestCase
  setup do
    @stream = streams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:streams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stream" do
    assert_difference('Stream.count') do
      post :create, stream: { mount: '/live',
                              server: 'http://server.com:8888',
                              title: 'Accid' }
    end

    assert_redirected_to stream_path(assigns(:stream))
  end

  test "should not create invalid stream" do
    post :create, stream: { mount: @stream.mount,
                            server: @stream.server,
                            title: @stream.title }
    assert_template :new
    assert_select "#error_explanation ul li", 2
  end

  test "should show stream" do
    get :show, id: @stream
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stream
    assert_response :success
  end

  test "should update stream" do
    patch :update, id: @stream, stream: { mount: @stream.mount, server: @stream.server, title: @stream.title }
    assert_redirected_to @stream
  end

  test "should not update stream if invalid" do
    patch :update, id: streams(:rock), stream: { mount: @stream.mount, server: @stream.server, title: @stream.title }
    assert_template :edit
    assert_select "#error_explanation ul li", 2
  end

  test "should destroy stream" do
    assert_difference('Stream.count', -1) do
      delete :destroy, id: @stream
    end

    assert_redirected_to streams_path
  end

  test "should get playlist in json" do
    get :playlist, stream_id: streams(:rock), format: :json
    assert_response :success
    assert_equal JSON.parse(response.body)["history"].count, 2
  end

  test "should redirect get playlist if not json" do
    get :playlist, stream_id: @stream
    assert_redirected_to @stream
  end
end
