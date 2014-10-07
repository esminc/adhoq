Rails.application.routes.draw do
  root  to: 'hi#show'

  mount Adhoq::Engine => "/adhoq"
end
