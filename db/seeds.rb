# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.create(
  email: "qpdb96@gathering.com",
  password: "AEIO4310"
  )

10.times do |n|
  EndUser.create(
    name: "ユーザー#{n * 1}",
    email: "test#{n * 1}@test#{n * 1}",
    password: "#{111111 * n}"
  )
end

30.times do |n|
  Tag.create(
    name: "タグ#{n + 1}",
    status: 0
    )
end

30.times do |n|
  Genre.create(
    name: "ジャンル#{n + 1}",
    status: 0
    )
end

30.times do |n|
  Game.create(
    name: "ゲーム#{n + 1}",
    status: 0
    )
end