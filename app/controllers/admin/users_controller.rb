class Admin::UsersController < ApplicationController
  before_action :redirect_when_logged_in, only:[:new]
  before_action :login_check, only:[:show, :edit]
  before_action :set_user, only:[:edit, :update, :destroy]

  def index
    @users = User.order(created_at: "DESC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login
      redirect_to user_path(@user.id), notice: t('view.flash.user_create')
    else
      render :new  
    end  
  end

  def show
    if params[:id].to_i == current_user.id
      @user = User.find(params[:id]) 
      @tasks = @user.tasks.order(created_at: "DESC").page(params[:page]).per(20)
    else
      redirect_to root_path, notice: t('view.not_authorized') 
    end
  end  

  def edit
  end  

  def update
    @user.update(user_params)
    redirect_to user_path(@user.id), notice: t('view.flash.user_update')
  end
  
  def destroy
    @user.destroy
    redirect_to root_path, notice: t('view.flash.user_delete')
  end  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end  

  def set_user
    @user= User.find(params[:id])
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