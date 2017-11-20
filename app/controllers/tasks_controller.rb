class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @tasks = current_user.tasks.page(params[:page])
    end
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスクが正常に作成されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクが作成されませんでした"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] = "タスクは正常に変更されました"
      redirect_to @task
    else
      flash[:danger] = "タスクは変更されませんでした"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = "タスクは正常に削除されました"
    redirect_to tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
    redirect_to root_url if @task.user != current_user
  end
end
