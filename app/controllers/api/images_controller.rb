
class Api::ImagesController < ApplicationController

  before_action :set_date

  def daily
    image = Image.find_by(record_on: @date)

    if image.blank?
      flag, image = GenerateImageService.call(@date)
      render_error("@#{params['user_name']}，对不起，服务器网络开小差了，再重新试试呗") and return unless flag
    end

    render json: response_data(image)
  end

  private

  def set_date
    date = params['text'].split.last
    @date = Date.parse(date) rescue nil

    render_error("@#{params['user_name']}，输入的日期不对，最小1900年，🌰：2018-11-08") and return if @date.blank? || (@date.year < 1900)
  end

  def response_data(image)
    {
      "text": "@#{params['user_name']}，你要的日历来了😊",
      "attachments": [
          {
              "title": image.record_on,
              "text": "日历图",
              "color": "#666666",
              "images": [
                  "url": image.url
              ]
          }
      ]
    }
  end

end