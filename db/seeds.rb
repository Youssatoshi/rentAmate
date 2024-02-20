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

  roles = relationship_roles.sample()

  # Create a new profile associated with the user
  profile = Profile.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    bio: Faker::Lorem.paragraph(sentence_count: 3),
    phone_number: Faker::PhoneNumber.phone_number,
    address: Faker::Address.full_address,
    profile_picture_url: image_url,
    age: Faker::Number.between(from: 18, to: 90),
    user: user,  # Associate the profile with the created user
    roles: roles,
    price: Faker::Number.between(from: 67, to: 420),
  )
end
Profile.update_all(is_listed: true)
puts "All profiles have been updated to be listed."
puts "Seed data generated successfully!"
