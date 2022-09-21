class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]


  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

 def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(resource), notice: 'Welcome! You have signed up successfully.'
    end
 end



  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
      flash[:success] = "You have updated user successfully."
      redirect_to user_path(@user.id)
     else
       render :edit
     end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end
end
