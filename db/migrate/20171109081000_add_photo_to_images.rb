class AddPhotoToImages < ActiveRecord::Migration
  def change
  	add_attachment :images, :photo
  end
end
