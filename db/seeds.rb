# db/seeds.rb

# Require the Faker gem
require 'faker'
require 'json'
require 'open-uri'

# Define the number of fake profiles you want to create
NUM_PROFILES = 50

# Create fake users and profiles
NUM_PROFILES.times do
  # Create a new user
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password'  # Set a default password
    # You can add more attributes here if needed
  )
  url = 'https://100k-faces.glitch.me/random-image-url'
  image_data = JSON.parse(URI.open(url).read)
  image_url = image_data['url']
  # Create a new profile associated with the user
  profile = Profile.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    bio: Faker::Lorem.paragraph(sentence_count: 3),
    phone_number: Faker::PhoneNumber.phone_number,
    address: Faker::Address.full_address,
    profile_picture_url: image_url,
    age: Faker::Number.between(from: 18, to: 90),
    user: user  # Associate the profile with the created user
  )
end
puts "Seed data generated successfully!"
