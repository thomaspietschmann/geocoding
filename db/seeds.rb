# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

while Flat.count < 10
  p "Creating flat #{Flat.count + 1}"
  flat = Flat.new(
    name: Faker::FunnyName.two_word_name,
    address: Faker::Address.full_address,
  )
  flat.save!
end

p "Done creating flats"
