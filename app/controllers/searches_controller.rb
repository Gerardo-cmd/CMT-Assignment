require 'httparty'
class SearchesController < ApplicationController
  include HTTParty
  # http_basic_authenticate_with name: "admin", password: "admin"
  #, except: [:index, :show]
  def index
    @searches = Search.order("updated_at").reverse_order
  end

  def show
    @search = Search.find(params[:id])
  end

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(call_params)

    @searches = Search.all
    @searches.each do |number|
      if (number.npi == @search.npi)
        number.touch
        redirect_to number
        return
      end
    end

    begin
      response = HTTParty.get("https://npiregistry.cms.hhs.gov/api/?number="+ @search.npi + "&pretty=on&version=2.0")&.parsed_response["results"][0]
    rescue => exception
      flash.alert = "Search failed: Try another NPI!"
      redirect_to searches_path
      return
    end

    if (response == nil)
      flash.alert = "NPI not found, please try another npi!"
      redirect_to searches_path
      return
    end

    #No practice location: 1750312773, Maybe look into getting telephone number from address instead of practice location???
    
    @search.update(address: response["addresses"][0]["address_1"])
    @search.update(city: response["addresses"][0]["city"])
    @search.update(state: response["addresses"][0]["state"])
    @search.update(first_name: response["basic"]["first_name"])
    @search.update(last_name: response["basic"]["last_name"])
    @search.update(phone_number: response["addresses"][0]["telephone_number"])
    @search.update(taxonomy: response["taxonomies"][0]["desc"])    

    #NPI is unique and saving was successful
    if (@search.save)
      flash.alert = "NPI successfully saved to search history"
      redirect_to @search
      return
    end
  end

  def destroy 
    @searches = Search.all@searches.each do |search|
      search.destroy
    end

    redirect_to root_path
  end

  private
    def call_params
      params.require(:search).permit(:npi)
    end
end
