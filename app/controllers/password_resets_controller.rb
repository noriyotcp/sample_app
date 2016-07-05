class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'Email has sent with password reset instruction'
      redirect_to root_url
    else
      flash.now[:danger] = 'Email address not found'
      render 'new'
    end
  end

  def edit
  end

  private

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    # params[:id] is reset_token
    redirect_to root_url unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
  end
end
