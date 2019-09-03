# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.find_or_create_by(category_name: 'Electronics')
Category.find_or_create_by(category_name: 'Men')
Category.find_or_create_by(category_name: 'Women')
Category.find_or_create_by(category_name: 'Baby & Kids')
Category.find_or_create_by(category_name: 'Home & Furniture')
Category.find_or_create_by(category_name: 'Sports & Others')
