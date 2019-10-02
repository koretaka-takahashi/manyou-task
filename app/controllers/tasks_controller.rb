class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  before_action :login_check
  PER = 10

  # def index
  #   if params[:task] && params[:task][:search] # 検索の場合


  # end  

  def index
    if params[:sort_by_deadline] # 期限順
      @tasks = current_user.tasks.page(params[:page]).per(PER).sort_by_deadline
    elsif params[:sort_by_priority] # 優先順
      @tasks = current_user.tasks.page(params[:page]).per(PER).sort_by_priority
    elsif params[:task] && params[:task][:search] # 検索の場合
      task_ids = TaskLabel.where(label_id: params[:task][:search_task_label]).pluck(:task_id)
      if params[:task][:search_task_status] == '' # 状態が空の場合
        @tasks = current_user.tasks.search_by_name(params).page(params[:page]).per(PER) # 名前で検索、ラベルもあれば名前とラベルで検索
        @tasks = @tasks.where(id: task_ids).page(params[:page]).per(PER) if params[:task][:search_task_label].present?
      else  # 名前と状態で検索、ラベルもあれば全てで検索
        @tasks = current_user.tasks.search_by_name(params).search_by_status(params).page(params[:page]).per(PER)
        @tasks = @tasks.page(params[:page]).per(PER).where(id: task_ids) if params[:task][:search_task_label].present?
      end
    else  # デフォルト並び替え（作成順）
      @tasks = current_user.tasks.page(params[:page]).per(PER).sort_by_created_at
    end
  end

  def new
    @task = Task.new
  end

  def confirm
    @task = current_user.tasks.build(task_params)
  end  

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      if params[:task][:label_ids].present?
        params[:task][:label_ids].split.each do |label_id|
          TaskLabel.create(task_id: @task.id, label_id: label_id)
        end
      end
      redirect_to task_path(@task.id), notice: t('view.flash.success')
    else
      render :new
    end
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
    params.require(:task).permit(:name, :content, :deadline, :status, :priority, label_ids:[])
  end
end
