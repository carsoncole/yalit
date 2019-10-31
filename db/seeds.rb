# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

project = Project.create(name: 'Grade.us API (Version 4)')

chapters = ["Introduction", "Getting started", "Authentication", "Error handling", "Endpoints"]

chapters.each do |c|
  project.chapters.create(title: c)
end