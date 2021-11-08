class AddGeographicInfoToSpot < ActiveRecord::Migration[5.2]
  def change
    add_column :spots, :place_id, :string
    add_column :spots, :lat, :float
    add_column :spots, :lng, :float
    add_index  :spots, :place_id, unique: true
  end
end
