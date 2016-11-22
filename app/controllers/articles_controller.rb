class ArticlesController < ApplicationController
  load_and_authorize_resource except: :create
  def index
    @articles = Article.paginate(page: params[:page], per_page: 2)
  end

  def show
  end

  def new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:alert] = 'Article successfully created'
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(update_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def search
    title = params[:q]
    @articles = Article.search(title)
    respond_to do |format|
      format.json { render json: @articles } unless title.empty?
    end
  end

  private

  def update_params
    # merge_params = params[:id] ? {user: current_user} : {}
    params.require(:article).permit(:title, :text, :avatar, :avatar, :avatar_remote_url, :delete_avatar, :create_date)
  end

  def article_params
    params.require(:article).permit(:title, :text, :avatar, :avatar_remote_url, :create_date).merge(user: current_user)
  end
end
