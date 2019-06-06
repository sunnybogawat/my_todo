class TasksController < ApplicationController
    before_action :set_project
    before_action :set_task, except: [:create]
    
    def create
     @task = @project.tasks.create(task_params)
     redirect_to @project
    end
    
    def destroy
     @task = @project.tasks.find(params[:id])
     if @task.destroy
      flash[:success] = "Project task was deleted."
     else
      flash[:error] = "Project task could not be deleted."
     end
     redirect_to @project 
    end
    
    def complete
     @task.update_attributes(:status=> "Completed",:completed_at => Time.now)
     redirect_to @project, notice: "Task is marked as completed"
    end

    private
    def set_project
     @project = Project.find(params[:project_id])
    end
    
    def set_task
     @task = @project.tasks.find(params[:id])
    end
    
    def task_params
     Rails.logger.info ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
     Rails.logger.info params[:task]
     params[:task].permit(:content,:user_id,:status)
    end
end
