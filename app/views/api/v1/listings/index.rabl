node(:links) do
  {
    "first" => @first_page,
    "last"  => @last_page,
    "next" => @next_page,
    "prev" => @prev_page 
  }
end

node(:type) {"FeatureCollection"}

node(:features) do
  @listings.map do |listing|
    {
      type: "feature",
      geometry: {type: "Point", coordinates: [listing.lat, listing.lng]},
      properties: {
        id: listing.id,
        street: listing.street,
        price: listing.price,
        bedrooms: listing.bedrooms,
        bathrooms: listing.bathrooms,
        sq_ft: listing.square_feet
      }
    }
  end
end
