require "rails_helper"

def decoded_response
  ActiveSupport::JSON.decode(response.body)
end

describe Api::V1::ListingsController do
  render_views
  before :example do
    credentials = ActionController::HttpAuthentication::Basic.encode_credentials('opendoor', 'foobar')
    request.env["HTTP_AUTHORIZATION"] = credentials
  end

  context "index" do

    before :example do
      @listing = FactoryGirl.create(:listing)
      get :index, {min_bed: 1, min_price: 100000}
    end

    it "should return a successful response" do
      expect(response).to be_success
    end

    it "should return the listing" do
      expect( decoded_response["features"].size).to eq(1)
      expect( decoded_response["features"].first["properties"]["id"] ).to eq(@listing.id)
    end

    it "should return pagination links in the response headers" do
      allow_any_instance_of(Api::V1::ListingsController).to receive(:pagination_links).and_return(["<http://nextlink.com>"])
      get :index, {min_bed: 1, min_price: 100000}
      expect(response.headers.key?("Link")).to be_truthy
    end

  end

end