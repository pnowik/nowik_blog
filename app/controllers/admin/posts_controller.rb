class Admin::PostsController < Admin::BaseController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 20)
  end

  def show
    @comment = Comment.new
    @comment.post_id = @post.id
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.build(allowed_params)

    if @post.save
      flash[:success] = "Created new post"
      redirect_to admin_post_path(@post.id)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = current_user
    if @post.update_attributes(allowed_params)
      flash[:success] = "Updated post"
      redirect_to admin_post_path(@post.id)
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path
    flash[:success] = "deleted post"
  end

  def show_comments

  end

  private
  def allowed_params
    params.require(:post).permit(:title, :subtitle, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
