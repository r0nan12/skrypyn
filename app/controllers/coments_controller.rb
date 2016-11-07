class ComentsController < ApplicationController
  load_and_authorize_resource :except => [:create]

  def index
    @article = Article.find(params[:article_id])
    @comments = @article.coments
    @user = @coments.user
  end

    def create
      @article = Article.find(params[:article_id])
      @coment = @article.coments.build(comment_params)
      @coment.user = current_user
      @coment.save
      redirect_to article_path(@article)
    end

  def edit
    @coment = Coment.find(params[:id])
    @article = @coment.article
  end

  def update

    @coment = Coment.find(params[:id])
    @article = @coment.article

    if @coment.update(comment_params)
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @coment = Coment.find(params[:id])
    @article = @coment.article
    @coment.destroy
    redirect_to article_path(@article)
  end



    private

    def comment_params
      params.require(:coment).permit(:text)
    end



end
