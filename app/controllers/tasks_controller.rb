class TasksController < ApplicationController
    before_action :require_user_logged_in
    def index
        @tasks = current_user.tasks
    end
    def show
        @task = Task.find(params[:id])
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
        @task = Task.find(params[:id])
        if @task.update(task_params)
            flash[:success] = "正常に編集されました"
            redirect_to @task
        else
            flash.now[:danger] = "編集に失敗しました"
            render :edit
        end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = "削除が完了しました"
        redirect_to tasks_url
    end

    private

    def task_params
        params.require(:task).permit(:content, :status)
    end
end