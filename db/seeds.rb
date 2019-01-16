# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..50).each do |number|
  user = User.new(name: "test#{number.to_s}", email: "#{number.to_s}@#{number.to_s}.com", password: number.to_s)
  user.save
end