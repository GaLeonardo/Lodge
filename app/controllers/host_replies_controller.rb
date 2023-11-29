class HostRepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_review

  def new
    @host_reply = HostReply.new
  end

  def create
    @host_reply = @review.build_host_reply(host_reply_params)

    if @host_reply.save
      return redirect_to my_lodge_ratings_path, notice: 'Resposta ao comentário realizada com sucesso.'
    end
  end

  private

  def host_reply_params
    params.require(:host_reply).permit(:reply)
  end

  def get_review
    @review = Review.find(params[:review_id])
  end
end