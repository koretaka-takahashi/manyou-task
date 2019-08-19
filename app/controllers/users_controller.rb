class UsersController < ApplicationController
  before_action :redirect_when_logged_in, only:[:new]
  before_action :login_check, only:[:show]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login
      redirect_to user_path(@user.id)
    else
      render :new  
    end  
  end

  def show
    if params[:id].to_i == current_user.id
      @user = User.find(params[:id]) 
    else
      redirect_to root_path, notice: t('view.not_authorized') 
    end
  end  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end  

  def redirect_when_logged_in
    if logged_in?
      redirect_to user_path(current_user.id), notice: t('view.must_logout_to_do')
    end  
  end

  def redirect_when_visit_others_page
    if params[:id].to_i != current_user.id
      redirect_to user_path(current_user.id), notice: t('view.not_authorized') 
    end  
  end 
end
