class UsersController < ApplicationController
  # before_action :logged_in_user, only: [ :index, :edit, :update, :destroy ]
  # before_action :correct_user, only: [ :edit, :update ]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = "Account created successfully."
      redirect_to root_url
    else
      render "new"
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
