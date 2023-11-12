class HomeController < ApplicationController
  before_action :require_hosts_lodge

  def index
    @recent_lodges = Lodge.last(3).reverse
    @lodges = Lodge.ativo.where.not(id: @recent_lodges.map(&:id))
    @cities = Lodge.ativo.map{ |l| l.city }.uniq.sort
  end
end