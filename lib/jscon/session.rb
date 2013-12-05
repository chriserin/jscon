module Jscon
  class Session
    extend Forwardable

    def initialize()
      load_rails_app
      configure_integration
      @session = ActionDispatch::Integration::Session.new(Rails.application)
    end

    def load_rails_app
      require File.join(::Dir.pwd, '/config/environment')
    end

    def configure_integration
      Rails.application.config.action_dispatch.show_exceptions = false
      ActionController::Base.instance_eval do
        define_method :protect_against_forgery? do
          false
        end
      end
    end

    def get(url)
      url = ::URI.encode(url) unless url.include? ?%
      @session.get(url)
    rescue Object => error
      puts error.message, stack(error)
      exit 1
    end

    def stack(error)
      return error.backtrace[0..10]
    end

    def_delegators :@session, :response
  end
end
