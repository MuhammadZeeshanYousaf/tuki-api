class Api::V1::CommunitiesController < ApplicationController
  before_action :authenticate_super_admin!, except: [ :show ]
  before_action :set_community, only: %i[ show update destroy ]

  # GET /communities
  def index
    @communities = Community.all

    render json: @communities, each_serializer: Api::V1::CommunitySerializer
  end

  # GET /communities/:id
  def show
    render json: @community, serializer: Api::V1::CommunitySerializer
  end

  # POST /communities
  def create
    @community = Community.new(community_params)

    if @community.save
      render json: @community, serializer: Api::V1::CommunitySerializer,
             status: :created, location: api_v1_community_url(@community, only_path: true)
    else
      render json: { error: full_error(@community) }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /communities/:id
  def update
    if @community.update(community_params)
      render json: @community, serializer: Api::V1::CommunitySerializer
    else
      render json: { error: full_error(@community) }, status: :unprocessable_entity
    end
  end

  # DELETE /communities/:id
  def destroy
    @community.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def community_params
      params.require(:community).permit(:name)
    end
end
