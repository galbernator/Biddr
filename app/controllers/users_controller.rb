class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @auctions = current_user.auctions
  end

  def edit
    @auction = Auction.find(params[:acution_id])
  end

  def update
    @user = User.find(current_user)
    if @user.update(user_params) && @user.authenticate(params[:confirm_password])
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    auction = Auction.find(params[:acution_id])
    auction.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit([:first_name, :last_name, :email, :password, :password_confirmation])
  end
end
