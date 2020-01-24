class TasksController < InheritedResources::Base
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @tasks = Idea.find(params[:idea_id]).tasks
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @task = Task.new
  end

  # GET /comments/1/edit
  def edit
    @idea = Idea.find(params[:idea_id])
    @task = @idea.tasks.find(params[:id])
  end





  def create
    @idea = Idea.find(params[:idea_id])
    @task =  @idea.tasks.create(task_params)

    respond_to do |format|
      if @task.save
        puts params
        format.html { redirect_to  idea_path(@idea), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :idea_id)
    end

end
