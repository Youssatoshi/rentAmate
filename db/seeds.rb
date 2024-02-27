# db/seeds.rb

# Require the Faker gem
require 'faker'
require 'open-uri'

# Define the number of fake profiles you want to create
NUM_PROFILES = 50

# Create fake users and profiles
NUM_PROFILES.times do |index|
  # Create a new user
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password', # Set a default password
    # You can add more attributes here if needed
  )
  image_url = "https://i.pravatar.cc/300?img=#{index}"
  relationship_roles = [
    "Mother", "Father", "Parent",
    "Son", "Daughter", "Child",
    "Grandmother", "Grandfather", "Grandparent",
    "Great Grandmother", "Great Grandfather", "Great Grandparent",
    "Aunt", "Uncle",
    "Niece", "Nephew",
    "Cousin",
    "Sibling",
    "Brother", "Sister",
    "Half-brother", "Half-sister",
    "Stepmother", "Stepfather", "Stepparent",
    "Stepson", "Stepdaughter", "Stepchild",
    "Stepsibling", "Stepbrother", "Stepsister",
    "Godmother", "Godfather", "Godparent",
    "Godson", "Goddaughter",
    "Friend",
    "Best Friend",
    "Close Friend",
    "Acquaintance",
    "Neighbor",
    "Roommate",
    "Partner",
    "Girlfriend", "Boyfriend",
    "Fiance", "Fiancee",
    "Husband", "Wife", "Spouse",
    "Ex-girlfriend", "Ex-boyfriend",
    "Ex-husband", "Ex-wife",
    "Lover",
    "Mentor", "Mentee",
    "Teacher", "Student",
    "Coach",
    "Colleague",
    "Boss", "Supervisor",
    "Employee", "Coworker",
    "Advisor", "Advisee",
    "Protector", "Protected",
    "Caretaker", "Care Receiver",
    "Legal Guardian",
    "Foster Parent", "Foster Child",
    "Volunteer",
    "Benefactor", "Beneficiary"
  ]

  address_array = [
    "1600 Amphitheatre Parkway, Mountain View, CA 94043, USA",

    "221B Baker Street, London NW1 6XE, United Kingdom",
    "10 Downing Street, London SW1A 2AA, United Kingdom",
    "350 Fifth Avenue, New York, NY 10118, USA",

    "Sydney Opera House, Sydney NSW 2000, Australia",

    "Christ the Redeemer, Alto da Boa Vista, Rio de Janeiro - RJ, Brazil",
    "Great Wall of China, Huairou, China",
  ]
  roles = relationship_roles.sample()
  address = address_array.sample()
  price = rand(1..99)

  # Use Geocoder gem to geocode the address and retrieve latitude and longitude
  geocoded_address = Geocoder.search(address).first
  latitude = geocoded_address&.latitude
  longitude = geocoded_address&.longitude
  complex_bio = "#{Faker::Name.name} was born on #{Faker::Date.backward(days: 15_000)}. #{Faker::Lorem.paragraph(sentence_count: 2)} In their professional life, #{Faker::Name.first_name} has contributed to #{Faker::Company.industry} through #{Faker::Company.name}, where they have been working since #{Faker::Date.backward(days: 1_000)}. Their work primarily focuses on #{Faker::Company.profession}. #{Faker::Lorem.paragraph(sentence_count: 2)}"

  # Create a new profile associated with the user
  if latitude && longitude
    profile = Profile.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      bio: complex_bio,
      phone_number: Faker::PhoneNumber.phone_number,
      address: address,
      latitude: latitude,
      longitude: longitude,
      profile_picture_url: image_url,
      age: Faker::Number.between(from: 18, to: 39),
      user: user,  # Associate the profile with the created user
      roles: roles,
      price: price,
    )
  else
    puts "Failed to geocode address: #{address}"
  end
end

Profile.update_all(is_listed: true)
puts "All profiles have been updated to be listed."
puts "Seed data generated successfully!"
