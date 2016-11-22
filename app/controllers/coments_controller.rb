class ComentsController < ApplicationController
  load_and_authorize_resource :article
  load_and_authorize_resource except: :create
  def index
  end

  def create
    @coment = Coment.new(comment_params)
    if @coment.save
      flash[:notice] = 'Comment was added success'
      redirect_to article_path(@article)
    else
      flash[:alert] = @coment.errors.full_messages
      redirect_to article_path(@article)
    end
  end

  def edit
  end

  def update
    if @coment.update(update_params)
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @coment.destroy
    redirect_to article_path(@article)
  end

  private

  def update_params
    params.require(:coment).permit(:text).merge(article: @article)
  end

  def comment_params
    params.require(:coment).permit(:text).merge(user: current_user, article: @article)
  end
end
