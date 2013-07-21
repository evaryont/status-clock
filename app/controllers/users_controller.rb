class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?, :except => [:index]
  before_filter :find_user, :only => [:edit, :update, :show]

  def index
    @users = User.all
  end

  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def show
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:provider, :uid, :name, :email)
    end
end
