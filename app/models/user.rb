class User < ActiveRecord::Base
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles
  after_initialize :set_default_role, :if => :new_record?
  validates :username, :presence => true
  before_validation :generate_password, :on => :create
  has_many :license_issue_activites

  #accepts_nested_attributes_for :user_roles, :allow_destroy => true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,  :timeoutable, :validatable, :timeout_in => 15.minutes

  def set_default_role
    self.roles ||= Role.where(:name => 'staff').first
  end
 #this method is called by devise to check for "active" state of the model
  def active_for_authentication?
    #remember to call the super
    #then put our own check to determine "active" state using 
    #our own "is_active" column
    super and self.is_active?
  end
 #def has_role?(name)
 #   roles.pluck(:name).member?(name.to_s)
 # end



 def has_role?(role_sym)
   roles.any? { |r| r.name.underscore.to_sym == role_sym }
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

  def is_admin?
    is_type?("admin")
  end

  def is_super_admin?
    is_type?("super_admin")
  end

  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end

  def is?(role)
   roles.include?(role.to_s)
  end

  private

 def generate_password
    o =  [('a'..'z'), ('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
    self.password = self.password_confirmation = (0..16).map{ o[rand(o.length)] }.join if     self.password.blank?
  end
  
  def is_type? type
    self.roles.map(&:name).include?(type) ? true : false # will return true if the param type is included in the user´s role´s names. 
  end
end
