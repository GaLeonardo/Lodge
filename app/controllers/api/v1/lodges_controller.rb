class Api::V1::LodgesController < Api::V1::ApiController
  def index
    lodges = Lodge.ativo.order(:brand_name)
    lodges = lodges.where("brand_name LIKE ?", "%#{params[:name]}%") if params[:name]

    render status: 200, json: lodges.as_json(except: [:status, :user_id, :created_at, :updated_at])
  end

  def show
    lodge = Lodge.find(params[:id])
    render status: 200, json: lodge.as_json(except: [:corporate_name, :registration_number, :user_id, :created_at, :updated_at], methods: :average_ratings)
  end
end