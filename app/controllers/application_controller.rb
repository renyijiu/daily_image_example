class ApplicationController < ActionController::API

  before_action :check_token

  def render_error(msg)
    render json: {
        "text": msg,
        "attachments": [
            {
                "title": '对不起，日历君有点小问题',
                "text": "500",
                "color": "#666666",
                "images": [
                    "url": 'https://i.loli.net/2018/11/06/5be17ccf84551.jpg'
                ]
            }
        ]
    }
  end

  private

  def check_token
    token = ENV.fetch('RAILS_BEARYCHAT_TOKEN', nil) || 'cbd543e98d886f9813a6fd9e17a7d66f'

    render_error("@#{params['user_name']}，对不起，token 验证不通过") and return unless token == params['token']
  end

end
