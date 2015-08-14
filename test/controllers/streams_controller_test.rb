require 'test_helper'

class StreamsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @stream = streams(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:streams)
  end

  test 'should get new' do
    sign_in :user, users(:admin)
    get :new
    assert_response :success
  end

  test 'should create stream' do
    sign_in :user, users(:admin)
    assert_difference('Stream.count') do
      post :create, stream: { mount: '/live',
                              server: 'http://server.com:8888',
                              title: 'Accid' }
    end

    assert_redirected_to stream_path(assigns(:stream))
  end

  test 'should not create invalid stream' do
    sign_in :user, users(:admin)
    post :create, stream: { mount: @stream.mount,
                            server: @stream.server,
                            title: @stream.title }
    assert_template :new
    assert_select "#error_explanation ul li", 2
  end

  test 'should show stream' do
    get :show, id: @stream
    assert_response :success
  end

  test 'admin: should get edit' do
    sign_in :user, users(:admin)
    get :edit, id: @stream
    assert_response :success
  end

  test 'registered: should not get edit' do
    sign_in :user, users(:registered)
    get :edit, id: @stream
    assert_redirected_to root_path
    assert_equal flash[:alert], 'Access Denied'
  end

  test 'admin: should update stream' do
    sign_in :user, users(:admin)
    patch :update, id: @stream, stream: { mount: @stream.mount, server: @stream.server, title: @stream.title }
    assert_redirected_to @stream
  end

  test 'registered: should not update stream' do
    sign_in :user, users(:registered)
    patch :update, id: @stream, stream: { mount: @stream.mount, server: @stream.server, title: @stream.title }
    assert_redirected_to root_path
    assert_equal flash[:alert], 'Access Denied'
  end

  test 'admin: should not update stream if invalid' do
    sign_in :user, users(:admin)
    patch :update, id: streams(:rock), stream: { mount: @stream.mount, server: @stream.server, title: @stream.title }
    assert_template :edit
    assert_select "#error_explanation ul li", 2
  end

  test 'admin: should destroy stream' do
    sign_in :user, users(:admin)
    assert_difference('Stream.count', -1) do
      delete :destroy, id: @stream
    end

    assert_redirected_to streams_path
  end

  test 'registered: should destroy stream' do
    sign_in :user, users(:registered)
    assert_difference('Stream.count', 0) do
      delete :destroy, id: @stream
    end

    assert_redirected_to root_path
    assert_equal flash[:alert], 'Access Denied'
  end

  test 'should get playlist in json' do
    get :playlist, stream_id: streams(:rock), format: :json
    assert_response :success
    assert_equal JSON.parse(response.body)['history'].count, 2
  end

  test 'should redirect get playlist if not json' do
    get :playlist, stream_id: @stream
    assert_redirected_to @stream
  end
end
