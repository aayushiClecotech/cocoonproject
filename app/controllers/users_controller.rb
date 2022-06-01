class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show 
    @user = User.find(params[:id])
  end 

  def new 
    @user = User.new 
  end 

  def create 
    @user = User.new(user_params)
    if @user.save 
      UserMailer.with(user: @user).welcome_email.deliver_now
      redirect_to @user 

    else 
      render :new , status: :unprocessable_entity
    end 
  end 


  def edit 
    @user = User.find(params[:id])
  end 

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user 
    else 
      render :edit, status: :unprocessable_entity
    end 
  end 

  def destroy
    @user = User.find(params[:id])
    @user.destroy 

    redirect_to @user 
  end

  private 

  def user_params 
    params.require(:user).permit(:name , :mobno, addresses_attributes: [:id,:city, :area, :street , :_destroy])
  end
end
