class HomeController < ApplicationController
  def index
    @lodge_houses = LodgeHouse.ativo
  end
end