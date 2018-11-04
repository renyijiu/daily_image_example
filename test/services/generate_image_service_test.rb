require 'test_helper'

class GenerateImageServiceTest < ActiveSupport::TestCase

  test "should generate the image when not exist" do
    file_name = Rails.root.join('tmp/', "daily_#{Date.today}.jpeg")

    assert_difference 'Image.count',1 do
      flag, image = GenerateImageService.call(Date.today.to_s)

      assert flag
      assert_not_empty image.url
    end

    assert File.exist?(file_name)
    File.delete(file_name)
  end

  test "should get the image when exist" do
    image = Image.create(record_on: Date.today, url: SecureRandom.hex(10))

    flag, res = GenerateImageService.call(Date.today.to_s)

    assert flag
    assert_equal image.url, res.url
  end
end