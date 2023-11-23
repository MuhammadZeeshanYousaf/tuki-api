class Api::V1::TenantsController < ApplicationController
  before_action :set_tenant, only: %i[ show update destroy ]

  # GET /tenants
  def index
    @tenants = Tenant.where apartment_id: params[:apartment_id]

    render json: @tenants, each_serializer: Api::V1::TenantSerializer
  end

  # GET /tenants/1
  def show
    render json: @tenant, serializer: Api::V1::TenantSerializer
  end

  # POST /tenants
  def create
    @tenant = Tenant.new(tenant_params)

    if @tenant.save
      render json: @tenant, serializer: Api::V1::TenantSerializer, status: :created, location: api_v1_tenant_path(@tenant)
    else
      render json: { error: full_error(@tenant) }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tenants/1
  def update
    if @tenant.update(tenant_params)
      render json: @tenant, serializer: Api::V1::TenantSerializer
    else
      render json: { error: full_error(@tenant) }, status: :unprocessable_entity
    end
  end

  # DELETE /tenants/1
  def destroy
    @tenant.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tenant
      @tenant = Tenant.find_by!(id: params[:id], apartment_id: params[:apartment_id])
    end

    # Only allow a list of trusted parameters through.
    def tenant_params
      params.require(:tenant).permit(:user_id, :owner_id, :tenantship_id)
    end
end
