class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def get_super_admin
    User.where(:id => self.id).first
  end 
  def add_licensee_role
    if self.license == true
      self.add_role :licensee_admin
    end
  end
end
