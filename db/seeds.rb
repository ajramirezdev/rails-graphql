30.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    mobile_number: Faker::PhoneNumber.cell_phone_in_e164,
    password: '111111',
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
    gender: %w[Male Female].sample,
    sexual_orientation: %w[Male Female].sample,
    gender_interest: %w[Male Female].sample,
    country: Faker::Address.country,
    state: Faker::Address.state,
    city: Faker::Address.city,
    school: Faker::University.name,
    bio: Faker::Lorem.paragraph(sentence_count: 5),
    images: Array.new(rand(1..5)) { Faker::Avatar.image(slug: Faker::Internet.slug, size: "300x300", format: "png") }
  )
end
