class Todo < ApplicationRecord
  # model association
  has_many :items, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by

  scope:filter_by_title, lambda {|keyword|
    where("lower(title) LIKE ?", "%#{keyword.downcase}")
  }

  scope:recent, -> {
    order(:update_at)
  }

  def self.search(params = {})
    todos = Todo.all
    todos = todos.filter_by_title(params[:keyword]) if params[:keyword]
    todos = todos.recent(params[:recent]) if params[:recent].present?
    todos
  end

end
