class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :street
      t.string :status
      t.decimal :price, precision: 8, scale: 2
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :square_feet
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
    end
  end
end
