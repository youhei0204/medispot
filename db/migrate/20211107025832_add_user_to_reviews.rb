class AddUserToReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :user, null: false, foreign_key: true
  end
end
