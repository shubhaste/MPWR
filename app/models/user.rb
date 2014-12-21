class User < ActiveRecord::Base
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 def has_role?(name)
    roles.pluck(:name).member?(name.to_s)
  end
  def is_staff?
    is_type?("staff")
  end

  def is_director?
    is_type?("director")
  end

  def is_minister?
    is_type?("minister")
  end

  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end
  private

  def is_type? type
    self.roles.map(&:name).include?(type) ? true : false # will return true if the param type is included in the user´s role´s names. 
  end
end
