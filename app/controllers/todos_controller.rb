class TodosController < ApplicationController
  before_action :set_todo, only: %i[ edit update destroy ]
  # after_update_commit { broadcast_append_to 'todos' }

  # GET /todos
  def index
    # @todos = Todo.in_order_of(:status, %w[incomplete complete])
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
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@todo)}_form", partial: "form",
                                                                                     locals: { todo: @todo })
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@todo)}_item", partial: "todo",
                                                                                     locals: { todo: @todo })
        end
        format.html { redirect_to todo_url(@todo), notice: "Todo was successfully updated." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@todo)}_form", partial: "form",
                                                                                     locals: { todo: @todo })
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@todo)}_item") }
      format.html { redirect_to todos_url, notice: "Todo was successfully destroyed." }
    end
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
