class ProductionCompaniesController < ApplicationController
  def index
    @production_companies = ProductionCompany.all
  end

  def show
    @production_company = ProductionCompany.find(params[:id])
  end
end
