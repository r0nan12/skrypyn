class ArticlesController < ApplicationController
    load_and_authorize_resource except: :create
    before_action :find_by_id, only: [:show,:edit,:update,:destroy]

def index
	@articles = Article.all

end

def show
end

def new
	@article = Article.new
end

def create
  create_date = params[:article][:create_date]
  if create_date
    params[:article][:create_date] = create_date.to_datetime
  end

  @article = Article.new(article_params)

  if @article.save
    flash[:alert] = "Article successfully created"
    redirect_to @article
  else
    render 'new'
    end
  end


def edit
end

def update
  if @article.update(article_params)
    redirect_to @article
  else
    render 'edit'
  end
end

def destroy
	@article.destroy
	redirect_to articles_path
end


   private

  def article_params
	  params.require(:article).permit( :title, :text, :create_date).merge(user: current_user)
  end

  private

  def find_by_id
    @article = Article.find(params[:id])
  end

end
