class AddForeignKeyToBugersAndReviews < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :reviews, :burgers
  end
end
