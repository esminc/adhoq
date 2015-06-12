# see https://github.com/amatsuda/kaminari/blob/master/lib/kaminari/config.rb
module Adhoq
  class Configuration
    include ActiveSupport::Configurable

    config_accessor :storage

    config_accessor :authorization
    config_accessor :authorization_failure_action

    config_accessor :current_user

    config_accessor :database_connection

    def callablize(name)
      if (c = config[name]).respond_to?(:call)
        c
      else
        c.to_proc
      end
    end
  end
end
