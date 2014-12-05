class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, :through => :user_roles

  # role model has for example following attributes:
  # name (e.g. Role.first.name => "admin" or "editor" or "whatever"
end