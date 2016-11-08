class SearchController < ApplicationController
  def index

    title = params[:q]
    @articles = Article.search(title)


    respond_to do |format|
      if @articles
        format.json { render json: @articles }
      end
    end
  end
end
