class ArticlesController < ApplicationController
    load_and_authorize_resource :except => [:create]

def index
	@articles = Article.all

end

def show
  @article = Article.find(params[:id])
end

def new
	@article = Article.new

end

def create

  @article = Article.create(article_params)
 current_user.articles << @article

  if @article.errors.empty?
    flash[:alert] = "Article successfully created"
    redirect_to @article
  else
    render 'new'
    end

  end


def edit
	@article = Article.find(params[:id])
end

def update
	 @article = Article.find(params[:id])
 
  if @article.update(article_params)
    redirect_to @article
  else
    render 'edit'
  end
end

def destroy
	@article = Article.find(params[:id])
	@article.destroy
	redirect_to articles_path
end



    private

  def article_params
	params.require(:article).permit( :title, :text, :create_date)
end
end
