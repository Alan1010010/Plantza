class AddDescriptionToPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :plants, :description, :string
  end
end
