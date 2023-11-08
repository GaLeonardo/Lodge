class HomeController < ApplicationController
  def index
    @lodges = Lodge.ativo
  end
end