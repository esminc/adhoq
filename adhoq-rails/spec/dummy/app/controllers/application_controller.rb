class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    OpenStruct.new(name: 'Alice', admin?: true)
  end

  def adhoq_authorized?
    current_user.admin?
  end
end
