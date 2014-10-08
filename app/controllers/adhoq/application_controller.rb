module Adhoq
  class ApplicationController < ::ApplicationController
    include Adhoq::AuthorizationMethods
  end
end
