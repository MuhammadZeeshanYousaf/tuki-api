require "rails_helper"

RSpec.describe QuinchosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/quinchos").to route_to("quinchos#index")
    end

    it "routes to #show" do
      expect(get: "/quinchos/1").to route_to("quinchos#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/quinchos").to route_to("quinchos#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/quinchos/1").to route_to("quinchos#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/quinchos/1").to route_to("quinchos#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/quinchos/1").to route_to("quinchos#destroy", id: "1")
    end
  end
end
