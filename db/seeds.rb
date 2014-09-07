# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Load default users
user_list = [
    [ 'Knut Esten Melandsø Nekså', 'knut.neksa@gmail.com',      'password' ],
    [ 'Vegar Krogh Arnesen',       'vkarnesen@gmail.com',       'password' ],
    [ 'Fredrik Wilhelm Borelly',   'friofredworld@hotmail.com', 'password' ]
]

user_list.each do |name, email, password|
  User.create(name: name, email: email, password: password)
end

