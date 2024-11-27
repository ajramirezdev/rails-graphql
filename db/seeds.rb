30.times do
  user = User.create!(
    email: Faker::Internet.email,
    name: Faker::Name.name,
    password: '11111'
  )

  Post.create!(
    user: user,
    title: Faker::Movie.title,
    content: Faker::Movie.quote
  )
end
