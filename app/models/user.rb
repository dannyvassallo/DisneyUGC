class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.search(search)
    where("email LIKE ?", "%#{search}%")
  end

  def admin?
   role == 'admin'
  end

  def reviewer?
   role == 'reviewer'
  end

end
