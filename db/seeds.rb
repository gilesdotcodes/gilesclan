# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_or_create_by(email: "s.giles@hotmail.co.uk")
user.password = '12345678'
user.password_confirmation = '12345678'
user.save!

user = User.find_or_create_by(email: "emmajohnston16@hotmail.com")
user.password = '12345678'
user.password_confirmation = '12345678'
user.save!

user = User.find_or_create_by(email: "davey_j_giles@hotmail.com")
user.password = '12345678'
user.password_confirmation = '12345678'
user.save!

user = User.find_or_create_by(email: "giles.clan@btinternet.com")
user.password = '12345678'
user.password_confirmation = '12345678'
user.save!

user = User.find_or_create_by(email: "carolanngiles@me.com")
user.password = '12345678'
user.password_confirmation = '12345678'
user.save!
