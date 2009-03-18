module Uaid
  module Helper
    def user_agent
      @user_agent ||= UserAgent.new(request.headers['user-agent'])
    end
  end
end