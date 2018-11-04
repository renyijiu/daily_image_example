require 'daily_image'

DailyImage.configure do |config|
  config.bg_color = [255, 255, 255]        # 背景颜色
  config.frame_color = [100, 150, 160]     # 边框颜色
  config.text_color = [100, 150, 160]      # 文字颜色
  config.date_color = [100, 150, 160]      # 中间日期颜色
  config.unused_color = [200, 205, 215]    # 进度条未使用颜色
  config.used_color = [100, 150, 160]      # 进度条已使用颜色
  config.out_frame_offset = 15             # 外层边框偏移量
  config.in_frame_offset = 50              # 下半部分内层边框偏移量
  config.font = 'Hiragino Sans GB'         # 文字默认字体
end