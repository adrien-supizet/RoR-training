require 'net/https'
require 'uri'
require "tatooine"

class CharactersController < ApplicationController

  def index
    @characters = Character.all
  end

  def show
    @character = Character.find(params[:id])
  end


  def create
    @character = Character.new(character_params)
    if @character.save
      redirect_to @character
    else
      render 'new'
    end
  end

  def new
=begin #standard fetch method
    uri = URI('https://swapi.co/api/species/')
    Net::HTTP.start(uri.host, uri.port,
                    :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request
    end
=end

#let's use the Star wars API gem
    species = Tatooine::Species.list
    (Tatooine::Species.count/10).times do #10 items per page
      species.concat Tatooine::Species.next
    end
    @species = species.map{|s| s.name}
    @character = Character.new()
  end

  def update
    @character = Character.find(params[:id])

    if @character.update(character_params)
      redirect_to @character
    else
      render 'edit'
    end
  end


  def destroy
    @character = Character.find(params[:id])
    @character.destroy

    redirect_to characters_path
  end


  private
  def character_params
    params.require(:character).permit(:name, :species)
  end
end
