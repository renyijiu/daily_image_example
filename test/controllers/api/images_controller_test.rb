require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest

  test "should get the image res" do
    params = {
        "token" => "cbd543e98d886f9813a6fd9e17a7d66f",
        "ts" => 1355517523,
        "text" => "@日历 1900-01-01",
        "trigger_word" => "@日历",
        "subdomain" => "test",
        "channel_name" => "your_channel",
        "user_name" => "your_name"
    }

    assert_difference 'Image.count', 1 do
      post daily_api_images_path, params: params

      res = JSON.parse(response.body)
      p res
      assert_kind_of Hash, res
    end
  end

  test "should get the image res when error date" do
    params = {
        "token" => "cbd543e98d886f9813a6fd9e17a7d66f",
        "ts" => 1355517523,
        "text" => "@日历 1900-11-41",
        "trigger_word" => "@日历",
        "subdomain" => "test",
        "channel_name" => "your_channel",
        "user_name" => "your_name"
    }

    post daily_api_images_path, params: params

    res = JSON.parse(response.body)
    p res
    assert_kind_of Hash, res
  end

end