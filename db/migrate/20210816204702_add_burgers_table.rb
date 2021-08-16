class AddBurgersTable < ActiveRecord::Migration[6.1]
  def change
    create_table :burgers do |t|
      t.column :name, :string
      t.column :description, :string
      t.column :insipration, :string
      t.column :drink_special, :string
      t.column :address, :string
      t.column :hours_of_availability, :string
    end
  end
end
