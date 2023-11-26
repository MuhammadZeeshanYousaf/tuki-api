require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/quinchos", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Quincho. As you add validations to Quincho, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # QuinchosController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Quincho.create! valid_attributes
      get quinchos_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      quincho = Quincho.create! valid_attributes
      get quincho_url(quincho), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Quincho" do
        expect {
          post quinchos_url,
               params: { quincho: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Quincho, :count).by(1)
      end

      it "renders a JSON response with the new quincho" do
        post quinchos_url,
             params: { quincho: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Quincho" do
        expect {
          post quinchos_url,
               params: { quincho: invalid_attributes }, as: :json
        }.to change(Quincho, :count).by(0)
      end

      it "renders a JSON response with errors for the new quincho" do
        post quinchos_url,
             params: { quincho: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested quincho" do
        quincho = Quincho.create! valid_attributes
        patch quincho_url(quincho),
              params: { quincho: new_attributes }, headers: valid_headers, as: :json
        quincho.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the quincho" do
        quincho = Quincho.create! valid_attributes
        patch quincho_url(quincho),
              params: { quincho: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the quincho" do
        quincho = Quincho.create! valid_attributes
        patch quincho_url(quincho),
              params: { quincho: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested quincho" do
      quincho = Quincho.create! valid_attributes
      expect {
        delete quincho_url(quincho), headers: valid_headers, as: :json
      }.to change(Quincho, :count).by(-1)
    end
  end
end
