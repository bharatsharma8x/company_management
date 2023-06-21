require 'test_helper'

class PeriferalsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get periferals_index_url
    assert_response :success
  end

  test 'should get new' do
    get periferals_new_url
    assert_response :success
  end

  test 'should get create' do
    get periferals_create_url
    assert_response :success
  end

  test 'should get edit' do
    get periferals_edit_url
    assert_response :success
  end

  test 'should get update' do
    get periferals_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get periferals_destroy_url
    assert_response :success
  end

  test 'should get show' do
    get periferals_show_url
    assert_response :success
  end
end
