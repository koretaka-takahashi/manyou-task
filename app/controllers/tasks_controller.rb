class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  before_action :login_check
  PER = 10

  def index
    if params[:sort_by_deadline] # 期限順の場合
      @tasks = current_user.tasks.page(params[:page]).per(PER).sort_by_deadline
    elsif params[:sort_by_priority] # 優先順の場合
      @tasks = current_user.tasks.page(params[:page]).per(PER).sort_by_priority
    elsif params[:task] && params[:task][:search] # 検索の場合で
      if params[:task][:search_task_status] == '' # 名前のみ検索の場合
        @tasks = current_user.tasks.page(params[:page]).per(PER).search_by_name(params)
        return
      end  # 名前と状態両方の検索の場合
      @tasks = current_user.tasks.page(params[:page]).per(PER).search_by_name(params).search_by_status(params)
    else  # デフォルト並び替え（作成順）の場合
      @tasks = current_user.tasks.page(params[:page]).per(PER).sort_by_created_at
    end
  end

  def new
    @task = Task.new
  end

  def confirm
    @task = Task.new(task_params)
  end  

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice: t('view.flash.success')
    end
    render :new
  end

  def show
  end

  def edit
  end

  def update
    @task.update(task_params)   # (@task.id)無くてもshowに行けるの何故？？？？？
    redirect_to task_path(@task.id), notice: t('view.flash.update')
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: t('view.flash.delete')
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content, :deadline, :status, :priority)
  end

  def login_check
    render 'sessions/new' if logged_in? == false
  end  

  # 多分必要なくなる
  # def query
  #   if params[:task].present? && params[:task][:name]
  #     Task.where('name LIKE ?', "%#{params[:task][:name]}%")
  #   else
  #     Task.order(created_at: "DESC")
  #   end
  # end
end
