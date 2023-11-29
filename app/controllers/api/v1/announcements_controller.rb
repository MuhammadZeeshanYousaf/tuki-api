class Api::V1::AnnouncementsController < Api::V1::BaseController
  before_action :set_announcement, only: %i[ show update destroy ]

  # GET /announcements
  def index
    if current_api_v1_user.role_admin?
      render json: current_api_v1_user.announcements
    else
      render json: current_api_v1_user.my_announcements
    end
  end

  # GET /announcements/1
  def show
    render json: @announcement
  end

  # POST /announcements
  def create
    authorize! :create, Announcement
    @announcement = current_api_v1_user.announcements.new(announcement_params.merge(group: params[:group]))
    authorize! :announced_to, @announcement

    if @announcement.save
      render json: @announcement, serializer: AnnouncementSerializer,
             status: :created, location: api_v1_announcement_path(@announcement)
    else
      render json: { error: full_error(@announcement) }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /announcements/1
  def update
    if @announcement.update(announcement_params)
      render json: @announcement
    else
      render json: @announcement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /announcements/1
  def destroy
    @announcement.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def announcement_params
      params.require(:announcement).permit(:topic, :content, :announced_to)
    end
end
