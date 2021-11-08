class AddSpotToReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :spot, null: false, foreign_key: true
  end
end
