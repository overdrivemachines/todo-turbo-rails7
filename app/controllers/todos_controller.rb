class TodosController < ApplicationController
  before_action :set_todo, only: %i[ edit update destroy ]

  # GET /todos
  def index
    @todos = Todo.all
  end

  # GET /todos/1/edit
  def edit; end

  # POST /todos
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.turbo_stream
        format.html { redirect_to todo_url(@todo), notice: "Todo was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: "Todo was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
    redirect_to todos_url, notice: "Todo was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def todo_params
    params.require(:todo).permit(:title, :status)
  end
end
