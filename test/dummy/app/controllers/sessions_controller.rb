class SessionsController < ApplicationController
  skip_before_action :redirect_to_new_session_path, only: [:new, :create]
  before_action :redirect_to_root_path, only: [:new, :create], if: :session_exists?
  before_action :set_session, only: :destroy

  def new
    @session = Session.new
  end

  def create
    @session = Session.new session_params

    if @session.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @session.destroy
    redirect_to new_session_path
  end

  protected

  def session_params
    params.require(:session).permit :email, :password
  end

  def redirect_to_root_path
    redirect_to root_path
  end
end
