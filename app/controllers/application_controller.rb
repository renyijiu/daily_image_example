class ApplicationController < ActionController::API

  before_action :check_token

  def render_error(msg)
    {
        "text": msg,
        "attachments": []
    }
  end

  private

  def check_token
    token = ENV.fetch('RAILS_BEARYCHAT_TOKEN', nil) || 'cbd543e98d886f9813a6fd9e17a7d66f'

    render_error('对不起，token 验证不通过') and return unless token == params['token']
  end

end
