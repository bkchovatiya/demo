# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  Customer.create!(first_name: 'BK', last_name:  'Chovatiya', email: 'bk@gmail.com', mobile_no: '2265070444', address: '193 Crestmont Drive')
  ['Raised', 'Cake', 'Bars', 'Twists', 'Fritters'].each do |product_name|
    product = Product.create(name: product_name )
    ['Glazed', 'Sugar', 'Powder', 'Sprinkles', 'Fillings'].each do |product_addon_name|
      product.product_addons.create(name: product_addon_name)
    end
  end
end
