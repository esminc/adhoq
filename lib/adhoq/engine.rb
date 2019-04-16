# TODO where to write?
require 'font-awesome-sass'
require 'jquery-rails'
require 'active_decorator'
require 'sassc-rails'

module Adhoq
  class Engine < ::Rails::Engine
    isolate_namespace Adhoq

    config.generators do |g|
      g.test_framework      :rspec,        fixture: false
      g.fixture_replacement :factory_girl, dir:     'spec/factories'
    end
  end
end
