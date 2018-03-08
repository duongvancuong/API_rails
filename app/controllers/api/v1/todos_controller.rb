class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  #GET /todos
  def index
    @todos = current_user.todos.includes(:items).search(params).paginate(page: params[:page], per_page: params[:per_page] || 20)
    # json_response(hash_data)
    render json: @todos, meta: pagination_obj(params[:page], params[:per_page], @todos.total_pages, @todos.total_entries)
  end

  def create
    @todo = current_user.todos.build
    @todo = current_user.todos.create!(todo_params)
    json_response(@todo, :created)
  end

  def show
    render json: @todo
  end

  # PUT /todos/:id
  def update
    @todo.update(todo_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @todo.destroy
    head :no_content
  end

  private
  def todo_params
    # whitelist params
    params.permit(:title)
  end

  def set_todo
    @todo = Todo.includes(:items).find(params[:id])
  end

  def pagination_obj page, per_page, total_pages, total_entries
    {
      pagination:{
        page: page.to_i,
        per_page: per_page || 20,
        total_pages: total_pages,
        total_objects: total_entries
      }
    }
  end
end
