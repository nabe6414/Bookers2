class UsersController < ApplicationController
  def index
    @users = User.all
    @user_info = User.find(current_user.id)
    @post = Book.new
  end

  def show
    @user = User.find(params[:id])
    @user_info = User.find(params[:id])
    @post = Book.new
    @books = @user.books
  end

  def edit
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
    @user = User.find(params[:id])
  end

  def update
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:update_user] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
