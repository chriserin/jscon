module Jscon
  class Session
    extend Forwardable

    def self.rails_app_path
      File.join(::Dir.pwd, '/config/environment.rb')
    end

    def self.is_available?
      File.exists? rails_app_path
    end

    def initialize()
      load_rails_app
      configure_integration
      @session = ActionDispatch::Integration::Session.new(Rails.application)
    end

    def load_rails_app
      require Jscon::Session.rails_app_path
    end

    def configure_integration
      #deliver stack trace instead of html error message
      Rails.application.config.action_dispatch.show_exceptions = false
      #allow posts without session authentication tokens
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
