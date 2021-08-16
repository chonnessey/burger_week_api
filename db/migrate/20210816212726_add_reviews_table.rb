class AddReviewsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.column :author, :string
      t.column :content, :string
      t.column :rating, :integer
      t.column :burger_id, :integer
    end
  end
end
