class IdeasController < ApplicationController
  def index
    @ideas = Idea.all
    #following code to display matching recipes in descending order from the time they were created
    if params[:search]
        @ideas = Idea.search(params[:search]).order("created_at DESC")
      else
        @ideas = Idea.all.order("created_at DESC")
    end
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def new
    @idea = Idea.new
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def create
    @idea = Idea.new(idea_params)

    if @idea.save
      redirect_to @idea
    else
      render 'new'
    end
  end

  def udpate
    @idea = Idea.find(params[:id])

    if @idea.update(idea_params)
      redirect_to @idea
    else
      render 'new'
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy

    redirect_to ideas_path
  end

  private

  def idea_params
    params.require(:idea).permit(:title,:summary,:description, :problem, :guidance)
  end

end