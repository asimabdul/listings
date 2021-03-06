require "rails_helper"

describe Listing do

  context "scopes" do
    before :example do
      @listing1 = FactoryGirl.create(:listing, bathrooms: 1, bedrooms: 2)
      @listing2 = FactoryGirl.create(:listing, bedrooms: 2, bathrooms: 3)
      @listing3 = FactoryGirl.create(:listing, bedrooms: 4, bathrooms: 5, price: 145000)
    end

    it "should only fetch listings with 2 and 3 bedrooms" do
      records = Listing.min_bed(2).max_bed(3)
      expect(records).to match_array([@listing1, @listing2])
    end

    it "should only fetch listings with a min of 3 bathrooms" do
      records = Listing.min_bath(3)
      expect(records).to match_array([@listing2, @listing3])
    end

    it "should fetch listings with a min of 3 bathrooms and a max price of 150,000" do
      records = Listing.min_bath(3).max_price(150000)
      expect(records).to match_array([@listing3])
    end
  end

  context "Search" do
    before :example do
      @listing = FactoryGirl.create(:listing, bedrooms: 4, bathrooms: 5, price: 145000)
    end

    it "should return an empty array if no listings match the search criteria" do
      search_query = {"min_bed" => 2, "min_bath" => 2, "max_price" => 100000}
      expect(Listing.search(search_query)).to eq([])
    end

    it "should return listings which match the search criteria" do
      search_query = {"min_bath" => 1, "max_price" => 200000}
      expect(Listing.search(search_query)).to match_array(@listing)
    end

  end

end