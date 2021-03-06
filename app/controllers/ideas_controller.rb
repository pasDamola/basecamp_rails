class IdeasController < ApplicationController
  before_action :authenticate_user!
  include Devise::Controllers::Helpers 
  helper_method :current_user


  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  def addfriend
    @idea = Idea.find(params[:id])
    if @idea.users.include? User.find(params[:user_id])
      #Users must not be added twice
      respond_to do |format|
        format.html { redirect_to @idea, :notice => 'Users already exists in project'}
      end
    else
      @idea.users << User.find(params[:user_id])
      respond_to do |format|
        format.html { redirect_to @idea, :notice => 'User has been Added.' }
      end
    end
  end





  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = current_user.ideas.all
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @user_options = User.all.map{ |u| [ u.email, u.id ] }
    @comments = @idea.comments.all
    @comment = @idea.comments.build
    @tasks = @idea.tasks.all
    @task = @idea.tasks.build
    
  end

  # GET /ideas/new
  def new
    @idea = current_user.ideas.build
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = current_user.ideas.new(idea_params)
    @idea.users << current_user
    
    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:name, :description, images: [])
    end
end
