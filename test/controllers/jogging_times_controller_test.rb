require 'test_helper'

class JoggingTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @jogging_time = jogging_times(:one)
  end

  test 'should get index' do
    get jogging_times_url, as: :json
    assert_response :success
  end

  test 'should create jogging_time' do
    assert_difference('JoggingTime.count') do
      post jogging_times_url,
           params: { jogging_time: { date: @jogging_time.date, distance: @jogging_time.distance, time: @jogging_time.time, user_id: @jogging_time.user_id } }, as: :json
    end

    assert_response 201
  end

  test 'should show jogging_time' do
    get jogging_time_url(@jogging_time), as: :json
    assert_response :success
  end

  test 'should update jogging_time' do
    patch jogging_time_url(@jogging_time),
          params: { jogging_time: { date: @jogging_time.date, distance: @jogging_time.distance, time: @jogging_time.time, user_id: @jogging_time.user_id } }, as: :json
    assert_response 200
  end

  test 'should destroy jogging_time' do
    assert_difference('JoggingTime.count', -1) do
      delete jogging_time_url(@jogging_time), as: :json
    end

    assert_response 204
  end
end
