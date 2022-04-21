class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
   
  end
  
  def create
    @user = User.new(user_params)
    @user.user.id = current_user.id
    @user.save
    redirect_to books_path, notice: 'Signed in successfully.'
  end  
  
  def index
     @user = User.find(current_user.id)
     @users = User.all
     @book = Book.new
     
     
  end
  
  def update
     
     @user = User.find(params[:id])
     if @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user)
     else
       render :edit
     end
  end
  
  private
  
  def book_params
    params.permit(:title, :body)
  end  
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
