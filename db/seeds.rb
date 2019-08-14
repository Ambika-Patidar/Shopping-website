# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

electronics = Category.create(category_name: "Electronics")
men = Category.create(category_name: "Men")
women = Category.create(category_name: "Women")
baby_kids = Category.create(category_name: "Baby & Kids")
home_furniture = Category.create(category_name: "Home & Furniture")
sports_others = Category.create(category_name: "Sports & Others")