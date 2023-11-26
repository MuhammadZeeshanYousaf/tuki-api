require "rails_helper"

RSpec.describe ValidationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/validations").to route_to("validations#index")
    end

    it "routes to #show" do
      expect(get: "/validations/1").to route_to("validations#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/validations").to route_to("validations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/validations/1").to route_to("validations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/validations/1").to route_to("validations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/validations/1").to route_to("validations#destroy", id: "1")
    end
  end
end
