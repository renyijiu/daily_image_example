
class Api::ImagesController < ApplicationController

  before_action :set_date

  def daily
    image = Image.find_by(record_on: @date)

    if image.blank?
      flag, image = GenerateImageService.call(@date)
      render_error('对不起，服务器网络开小差了，再重新试试呗') and return unless flag
    end

    render json: response_data(image)
  end

  private

  def set_date
    date = params['text'].split.last
    @date = Date.parse(date) rescue nil

    render_error('输入的日期格式不对，🌰：2018-11-08') and return if @date.blank?
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