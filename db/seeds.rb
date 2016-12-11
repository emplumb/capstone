20.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
    name: "#{first_name} #{last_name}",
    email: "#{first_name}.#{last_name}@gmail.com",
    username: "#{first_name} + rand(1..90)",
    password: "password"
    )
end
