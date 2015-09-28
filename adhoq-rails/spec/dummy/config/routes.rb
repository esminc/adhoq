Rails.application.routes.draw do
  root  to: 'hi#show'

  mount Adhoq::Rails::Engine => "/adhoq"
end
