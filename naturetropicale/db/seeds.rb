# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# users = User.roles.map do |role, |
#   User.find_or_initialize_by(email: "#{role}@example.com") do |user|
#     user.assign_attributes(password: '123123123', password_confirmation: '123123123',role: role)
#     # user.profile.assign_attributes(approved: true)
#     # user.build_account(role: role).build_profile(first_name: "#{role}_name", last_name: "#{role}_last_name")
#     user.skip_confirmation!
#     user.save!
#   end
# end

Profile.delete_all
User.delete_all

admin = User.create( :email => "admin@naturetropicale.ca",:password => "password", :password_confirmation => "password",:role => 0, 
    :time_zone => "Eastern Time (US & Canada)"
)
admin.skip_confirmation!
admin.save!

adminprofile = Profile.create!(
    :nom => "admin",
    :prenom => "prenom admin",
    :approved => true,
    :user_id => admin.id
)
# admin.toggle!(:admin)
# adminprofile.toggle!(:admin)