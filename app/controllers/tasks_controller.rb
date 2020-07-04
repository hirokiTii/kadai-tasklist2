class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:show, :update, :destroy]
    def index
        @tasks = current_user.tasks
    end
    def show
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = "正常にタスクが登録されました"
            redirect_to task_path(@task)
        else
            flash.now[:danger] = "タスクの登録に失敗しました"
            render :new
        end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        if @task.update(task_params)
            flash[:success] = "正常に編集されました"
            redirect_to @task
        else
            flash.now[:danger] = "編集に失敗しました"
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = "削除が完了しました"
        redirect_to tasks_url
    end

    private

    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
end