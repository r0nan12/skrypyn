class ComentsController < ApplicationController
  load_and_authorize_resource :article
  load_and_authorize_resource except: :create
  def index
  end

  def create
    @coment = Coment.new(comment_params)
    if @coment.save
      flash[:success] = 'Comment added successfully'
      redirect_to article_path(@article)
    else
      flash[:danger] = @coment.errors.full_messages
      redirect_to article_path(@article)
    end
  end

  def edit
  end

  def update
    if @coment.update(comment_params)
      flash[:success] = 'Comment updated successfully'
      redirect_to article_path(@article)
    else
      flash[:danger] = @coment.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @coment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    merge_params = params[:id] ?  {article: @article } : { user: current_user, article: @article }
    params.require(:coment).permit(:text).merge(merge_params)
  end
end
