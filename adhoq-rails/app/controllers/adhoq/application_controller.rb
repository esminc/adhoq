module Adhoq
  class ApplicationController < ::ApplicationController
    layout 'adhoq/application'

    include Adhoq::AuthorizationMethods
  end
end
