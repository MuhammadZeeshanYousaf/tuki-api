class Api::V1::TenantsController < Api::V1::BaseController
  before_action :set_owner, only: [ :index, :create ]
  before_action :set_tenant, only: %i[ show destroy eliminate ]

  # GET /tenants
  def index
    authorize! :index, Tenant
    render json: @owner.tenants, each_serializer: TenantSerializer
  end

  # GET /tenants/1
  def show
    authorize! :show, @tenant
    render json: @tenant, serializer: TenantSerializer
  end

  # POST /tenants
  def create
    authorize! :create, Tenant

    ActiveRecord::Base.transaction do
      # Create login account for Tenant
      account = @community.users.new account_params.merge(role: Role.find_by_key(:tenant))
      return render(json: { error: full_error(account) }, status: :unprocessable_entity) unless account.save

      # Create Apartment tenant
      @tenant = @owner.tenants.new(user: account)

      # Response
      if @tenant.save
        render json: @tenant, serializer: TenantSerializer,
               status: :created, location: api_v1_tenant_path(@tenant)
      else
        render json: { error: full_error(@tenant) }, status: :unprocessable_entity
      end
    end
  end

  # DELETE /tenants/1
  def destroy
    authorize! :destroy, @tenant

    ActiveRecord::Base.transaction do
      if @tenant.co_tenants.present?
        co_tenants_account_ids = @tenant.co_tenants.pluck :user_id
        User.destroy_by id: co_tenants_account_ids
      end
      @tenant.account.destroy!
    end
  end

  # DELETE /tenants/:id/eliminate
  def eliminate
    authorize! :eliminate, @tenant

    eliminated_account = EliminatedAccount.find_or_initialize_by eliminate_params.merge(eliminated: @tenant)

    if eliminated_account.save
      head :no_content
    else
      head :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tenant
      @tenant = Tenant.find(params[:id])
    end

    def set_owner
      @owner = current_api_v1_user&.owner
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:tenant).permit(:first_name, :last_name, :nationality, :national_id, :contact, :birthdate, :email, :password, :avatar)
    end

    def eliminate_params
      params.require(:tenant).permit(:reason, :message)
    end
end
