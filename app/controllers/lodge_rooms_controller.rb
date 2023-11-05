class LodgeRoomsController < ApplicationController
  def new
    @lodge_room = LodgeRoom.new
  end
end