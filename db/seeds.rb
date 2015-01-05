# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create a role named "admin"
#admin_role = Role.create!(:name => "admin")

# create an admin user
#admin_user = User.create!(:email => "admin@admin.com")

# assign the admin role to the admin user.  (This bit of rails
# magic creates a user_role record in the database.)
#admin_user.roles << admin_role

#pif_role = Role.create!(:name => "staff")
#pif_user = User.create!(:username => "Staff",:email => "staffsomalia@gmail.com",:password =>'staffsomalia123')
#pif_user.roles << pif_role

#gd_role = Role.create!(:name => "director")
#gd_user = User.create!(:username => "Director",:email => "directorsomalia@gmail.com",:password =>'directorsomalia1234')
#gd_user.roles << gd_role

#mn_role = Role.create!(:name => "minister")
#mn_user = User.create!(:username => "Minister",:email => "ministersomalia@gmail.com",:password =>'ministersomalia1234')
#mn_user.roles << mn_role

#mn_role1 = Role.create!(:name => "super_admin")
#pif_user1 = User.create!(:username => "Prashanth",:email => "prashanth.bsp@gmail.com",:password =>'pbs12345')
#pif_user1.roles << mn_role1

mn_role2 = Role.create!(:name => "admin")
pif_user2 = User.create!(:username => "Raghussss",:email => "prashanthbsp1982111@gmail.com",:password =>'pbs12345')
pif_user2.roles << mn_role2

