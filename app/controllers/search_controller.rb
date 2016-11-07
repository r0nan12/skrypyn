class SearchController < ApplicationController
  def index

    #/////////////////////////////////////////////////////////////////////

    @all_titles = Array.new
    @result_titles = Array.new
    search_param = params[:q]
    @articles = Article.all
    @result_articles = Array.new


    @articles.each do |f|
      @all_titles << f.title
    end
    unless search_param.empty?
      @all_titles.each do |f|
        temp = f.to_s.downcase
        if temp.include?(search_param.to_s.downcase)
          @result_titles << f
        end
      end
    end

    @result_titles.each_index do |i|
      @result_articles[i] = Article.find_by title: @result_titles[i]
    end


    #///////////////////////////////////////////////////////////////////////

    #//////////////////////////////////////////////////////////////////////
    respond_to do |format|
      if @result_titles
        format.json { render json: @result_articles }
      end
    end
  end


end
