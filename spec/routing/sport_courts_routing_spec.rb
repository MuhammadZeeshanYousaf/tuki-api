require "rails_helper"

RSpec.describe SportCourtsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/sport_courts").to route_to("sport_courts#index")
    end

    it "routes to #show" do
      expect(get: "/sport_courts/1").to route_to("sport_courts#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/sport_courts").to route_to("sport_courts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/sport_courts/1").to route_to("sport_courts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/sport_courts/1").to route_to("sport_courts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/sport_courts/1").to route_to("sport_courts#destroy", id: "1")
    end
  end
end
