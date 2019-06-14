class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to root_path, notice: 'タスクを作成しました'
  end

  def show
  end

  def edit
  end

  def update
    @task.update(task_params)
    redirect_to task_path, notice: 'タスクを更新しました'
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: 'タスクを削除しました'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content)
  end  
end
