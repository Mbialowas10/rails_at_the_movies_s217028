class ProductionCompaniesController < ApplicationController
  def index
    # @production_companies = ProductionCompany.all
    # @production_companies = ProductionCompany.select("production_companies.*")
    #                                           .select("COUNT(production_companies.id) as movie_count")
    #                                           .left_joins(:movies)
    #                                           .group("production_companies.id")
    #                                           .order("movie_count DESC")
    @production_companies = ProductionCompany.ordered_by_movies

    # select production_companies.id, production_companies.name, count(production_companies.id)
    # from production_companies
    # LEFT OUTER JOIN movies
    # ON movies.production_company_id = production_companies.id
    # GROUP By production_companies.id
    # order by 3 DESC
  end

  def show
    @production_company = ProductionCompany.find(params[:id])
  end
end
