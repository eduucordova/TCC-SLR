# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: 'user@home.com', password: 'teste', username: 'user1')
User.create!(email: 'user2@home.com', password: 'teste', username: 'user2')
User.create!(email: 'user3@home.com', password: 'teste', username: 'user3')
