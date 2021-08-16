class RenameInspoColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :burgers, :insipration, :inspiration
  end
end