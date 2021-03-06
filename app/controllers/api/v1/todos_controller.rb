class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    @todos = current_user.todos.includes(:items).search(params).paginate(page: params[:page], per_page: params[:per_page] ||= 20)
    render json: @todos, meta: json_pagination(params[:page], params[:per_page], @todos.total_pages, @todos.total_entries)
  end

  def create
    @todo = current_user.todos.build
    @todo = current_user.todos.create! todo_params
    json_response @todo, :created
  end

  def show
    render json: @todo
  end

  def update
    @todo.update todo_params
    head :no_content
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private
  def todo_params
    params.permit :title
  end

  def set_todo
    @todo = Todo.includes(:items).find(params[:id])
  end
end
