class Api::V1::CoOwnersController < Api::V1::BaseController
  before_action :set_owner
  before_action :set_co_owner, only: [ :show, :eliminate ]

  def index
    authorize! :index, :co_owners

    if current_api_v1_user.role_admin?
      co_owners = @community.co_owners
    else
      co_owners = @owner.co_owners
    end

    render json: co_owners, each_serializer: OwnerSerializer, root: 'co_owners'
  end

  def show
    authorize! :show, @co_owner

    render json: @co_owner, serializer: OwnerSerializer, root: 'co_owner'
  end

  def create
    authorize! :create, :co_owners
    
    ActiveRecord::Base.transaction do
      account = @community.users.new account_params.merge(role: Role.find_by_key(:co_owner))
      return render(json: { error: full_error(account) }, status: :unprocessable_entity) unless account.save

      @co_owner = @owner.co_owners.new(user: account, apartment_id: @owner.apartment_id)

      if @co_owner.save
        account.send_add_user_email
        render json: @co_owner, serializer: OwnerSerializer, root: 'co_owner',
               status: :created, location: api_v1_co_owner_path(@co_owner)
      else
        render json: { error: full_error(@co_owner) }, status: :unprocessable_entity
      end
    end
  end

  # DELETE /co_owners/:id/eliminate
  def eliminate
    authorize! :eliminate, @co_owner
    eliminated_account = EliminatedAccount.find_or_initialize_by eliminate_params.merge(eliminated: @co_owner)

    if eliminated_account.save
      head :no_content
    else
      head :unprocessable_entity
    end
  end


  private

    def set_owner
      @owner = current_api_v1_user&.owner
    end

    def set_co_owner
      if current_api_v1_user.role_admin?
        @co_owner = Owner.find(params[:id])
      else
        @co_owner = @owner.co_owners.find_by! id: params[:id]
      end
    end

    def account_params
      params.require(:co_owner).permit(:first_name, :last_name, :national_id, :contact, :birthdate, :email, :password)
    end

    def eliminate_params
      params.require(:co_owner).permit(:reason, :message)
    end
end
