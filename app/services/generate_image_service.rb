
class GenerateImageService
  include Servable

  def initialize(date)
    @date = date
    @api = 'https://sm.ms/api/upload'
    @file_path = Rails.root.join('tmp/')
  end

  def call
    image = Image.find_by(record_on: @date)
    return [true, image] if image.present?

    generate_image
    create_new_record
  end

  private

  def generate_image
    DailyImage.draw_image(@file_path, @date)
  end

  def create_new_record
    url = upload_image
    return [false, nil] if url.blank?

    image = Image.create(record_on: @date, url: url)
    [true, image]
  end

  def upload_image
    file_name = "daily_#{@date}.jpeg"

    response = HTTP.post(@api, :form => {
      :smfile => HTTP::FormData::File.new(File.join(@file_path, file_name))
    })

    res = JSON.parse(response.body.to_s) rescue {}
    res['code'] == 'success' ? res.dig('data', 'url') : nil
  end
end