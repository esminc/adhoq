# TODO where to write?
require 'rails/engine'
require 'adhoq-core'
require 'font-awesome-sass'
require 'jquery-rails'
require 'slim-rails'
require 'active_decorator'

module Adhoq
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace Adhoq

      config.generators do |g|
        g.test_framework      :rspec,        fixture: false
        g.fixture_replacement :factory_girl, dir:     'spec/factories'
      end
    end
  end
end
