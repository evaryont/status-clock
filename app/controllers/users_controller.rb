class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?, :except => [:index]
  before_filter :find_user, :only => [:edit, :update, :show, :status_update]

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

  def status_update
    @user.status_id = @user.clock.statuses[params[:lcd].to_i].id
    @user.status = @user.clock.statuses[params[:lcd].to_i]
    if @user.save
      redirect_to @user.clock, notice: "Status updated to #{@user.status.text}."
    else
      redirect_to @user.clock, alert: 'Failed updating status.'
    end
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:provider, :uid, :name, :email, :lcd)
    end
end
