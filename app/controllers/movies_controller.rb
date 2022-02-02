class MoviesController < ApplicationController
  def index
    #@movies = Movie.order("average_vote DESC"); # order by average_vote desc #creates the famous n+1 problem

    @movies = Movie.includes(:production_company).all.order("average_vote DESC")

  end

  def show
    @movie = Movie.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    @movies = Movie.where("title LIKE ?", wildcard_search)
  end
end
