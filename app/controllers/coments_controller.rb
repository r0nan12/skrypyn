class ComentsController < ApplicationController
  load_and_authorize_resource except: :create
  before_action :find_coment_by_id, only: [:index,:edit,:update,:destroy]
  before_action :find_article_by_id, only: [:edit,:update]

  def index
  end

  def create
    @coment = Coment.new(comment_params)
    if @coment.save
      flash[:notice] = "Comment was added success"
      redirect_to article_path(find_article_by_id)
  else
    flash[:alert] = @coment.errors.full_messages
    redirect_to article_path(find_article_by_id)
    end
  end

  def edit
  end

  def update
    if @coment.update(comment_params)
      redirect_to article_path(find_article_by_id)
    else
      render 'edit'
    end
  end

  def destroy
    @coment.destroy
    redirect_to article_path(find_article_by_id)
  end

  private

  def find_coment_by_id
    @coment = Coment.find(params[:id])
  end

  private

  def find_article_by_id
    @article = Article.find(params[:article_id])
  end


  private

  def comment_params
    params.require(:coment).permit(:text).merge(user: current_user, article: find_article_by_id )
  end



end
