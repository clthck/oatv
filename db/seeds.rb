# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seeds group of user roles
['super_admin', 'club_admin', 'player', 'coach'].each do |role|
	Role.find_or_create_by name: role
end

# Create a default admin user
# unless User.find_by email: 'admin@oa.tv'
# 	User.create email: 'admin@oa.tv', password: 'secret', password_confirmation: 'secret', confirmed_at: DateTime.now, role: Role.find_by(name: 'admin')
# end

# Seeds country tables
Country.all.each do |country|
	Oatv::Country.find_or_create_by name: country.name
end
