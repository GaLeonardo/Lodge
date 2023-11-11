class HomeController < ApplicationController
  before_action :require_hosts_lodge

  def index
    @recent_lodges = Lodge.last(3).reverse
    @lodges = Lodge.ativo.where.not(id: @recent_lodges.map(&:id))
  end
end