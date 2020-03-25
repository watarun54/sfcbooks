class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 例外処理
  if Rails.env.production? || Rails.env.staging?
    rescue_from Exception, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_404
    render template: 'errors/error_404', status: 404
  end

  def render_500
    render template: 'errors/error_500', status: 500
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
