class Image < ActiveRecord::Base
	has_attached_file :photo, {:styles => {:large => "640x640>",
                                         :small => "200x200>", 
                                         :thumb => "60x60>"},
                             :convert_options => {:large => "-strip -quality 90", 
                                         :small => "-strip -quality 80", 
                                         :thumb => "-strip -quality 80"}
                                         }
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"],:message => "please select valid format."
  before_save :rename_photo_name

  def image_url(style=:large)
  	style.present? ? self.photo.url(style) : self.photo.url
	end

  # def to_jq_upload
  #   {
  #     "name" => read_attribute(:image),
  #     "size" => image.size,
  #     "url" => image.url(:thumb),
  #     "thumbnail_url" => image.url(:thumb),
  #     "delete_url" => image.url(:thumb),
  #     "delete_type" => "DELETE" ,
  #     "id" => self.id
  #   }
  # end

  def rename_photo_name
    if (self.photo_updated_at_changed? and self.photo_file_name.present?)
      extension = File.extname(photo_file_name).downcase
      self.photo_file_name = "#{Time.now.to_i.to_s}#{extension}"
    end
  end
end
