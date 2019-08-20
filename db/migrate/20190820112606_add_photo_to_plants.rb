class AddPhotoToPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :plants, :photo, :string
  end
end
