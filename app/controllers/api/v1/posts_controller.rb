class Api::V1::PostsController < ApplicationController
  before_action :by_category, only: :index
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def create
    post = current_user.posts.create! post_params
    json_response @post, :created
  end

  def show
    json_response @post
  end

  def index
    posts = Post.all.desc
      .paginate(page: params[:page], per_page: params[:per_page] ||= 20) if params[:category_id].nil?
    posts = @category.posts.desc
      .paginate(page: params[:page], per_page: params[:per_page] ||= 10) if params[:category_id]
    render json: posts,
      meta: json_pagination(params[:page], params[:per_page], posts.total_pages, posts.total_entries)
  end

  def edit
    json_response @post
  end

  def show
    json_response @post
  end

  def update
    @post.update_attributes! post_params
    json_response @post
  end

  private
  def post_params
    params.permit :title, :content, :category_id
  end

  def by_category
    @category = Category.includes(:posts).find params[:category_id] if params[:category_id]
  end

  def find_post
    @post = Post.find params[:id]
  end
end
