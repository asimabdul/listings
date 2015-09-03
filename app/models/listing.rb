class Listing < ActiveRecord::Base

  paginates_per 20

  scope :min_bed, -> (min_bedrooms) {where("bedrooms >= ?", min_bedrooms)}
  scope :max_bed, -> (max_bedrooms) {where("bedrooms <= ?", max_bedrooms)}

  scope :min_price, -> (min_price) {where("price >= ?", min_price)}
  scope :max_price, -> (max_price) {where("price <= ?", max_price)}

  scope :min_bath, -> (min_bath) {where("bathrooms >= ?", min_bath)}
  scope :max_bath, -> (max_bath) {where("bathrooms <= ?", max_bath)}

  def self.search(filters)
    listings = where(nil)
    filters.each do |k,v|
      listings = listings.send(k.to_sym, v)
    end
    listings
  end

end