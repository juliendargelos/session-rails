class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_new_session_path, only:

  def show
    redirect_to edit_user_path(@user)
  end

  def new
    @user = User.new
  end

  def edit

  end

  def create
    @user = User.new user_params

    if @user.save
      Session.current.user = @user
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    @user.update user_params
    render :edit
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  protected

  def user_params
    params.require(:user).permit :email, :password, :password_confirmation
  end

  def set_user
    @user = Session.current.user
  end
end
