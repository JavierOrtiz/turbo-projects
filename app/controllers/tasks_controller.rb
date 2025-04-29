class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to [@task.project, @task], notice: "Project was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Task was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy!
  end

  private
    def set_task
      @task = Task.includes(:subtasks).find(params.expect(:id))
    end

    def task_params
      params.expect(task: [ :project_id, :status, :task_id, :content, :expires_at ])
    end
end
