class UsersController < ApplicationController
  before_action :is_matching_login_user1, only: [:edit, :update,]
    
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books 
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def index
    @user = current_user
    @book = Book.new
    @books = @user.books
    @users = User.all
  end

 def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
 end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_matching_login_user1
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  

end