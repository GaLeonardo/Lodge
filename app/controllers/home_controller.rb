class HomeController < ApplicationController
  before_action :require_hosts_lodge

  def index
    @lodges = Lodge.ativo
  end
end