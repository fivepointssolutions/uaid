module Uaid
  module ViewHelper
    def user_agent
      @user_agent ||= UserAgent.new(request.headers['user-agent'])
    end
  end
end