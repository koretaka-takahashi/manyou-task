class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]

  def index
    if params[:sort_by_deadline]
      @tasks = Task.order(deadline: "ASC")
    elsif params[:task] && params[:task][:search]
      @tasks = Task.where("name LIKE ?", "%#{ params[:task][:name]}%").where(status: params[:task][:status])
      # @tasks = Task.where("name LIKE ? AND status = ?", "%#{ params[:task][:name]}%", params[:task][:status])
    else  
      @tasks = Task.order(created_at: "DESC")
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
      redirect_to root_path, notice: t('view.flash.success')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @task.update(task_params)
    redirect_to task_path, notice: t('view.flash.update')
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
    params.require(:task).permit(:name, :content, :deadline, :status)
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
