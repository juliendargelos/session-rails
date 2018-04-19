class ApplicationController < ActionController::Base
  before_action :redirect_to_new_session_path, unless: :session_exists

  protected

  class << self
  def requires_authentication?
  end

  def redirect_to_new_session_path
    redirect_to new_session_path
  end

  def session_exists?
    Session.current.exists?
  end
end
