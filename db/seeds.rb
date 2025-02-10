# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

ethnicity_options = [
  "White",
  "Black or African American",
  "Asian",
  "American Indian or Alaska Native",
  "Native Hawaiian or Other Pacific Islander",
  "Hispanic or Latino",
  "Other",
  "Prefer not to say"
]

# Method to generate formatted phone numbers
def formatted_phone_number
  area_code = Faker::Number.number(digits: 3)
  prefix = Faker::Number.number(digits: 3)
  line_number = Faker::Number.number(digits: 4)
  "+1 (#{area_code}) #{prefix}-#{line_number}"
end

# Create 20 users with first-name-based emails
20.times do |i|
  first_name = Faker::Name.first_name.downcase
  last_name = Faker::Name.last_name.downcase
  email = "#{first_name}.#{last_name}@gmail.com"

  user = User.create!(
    first_name: first_name.capitalize,
    last_name: last_name.capitalize,
    email: email,
    phone_number: formatted_phone_number,
    gender: %w[Male Female].sample,
    age_range: %w[18-24 25-34 35-44 45-54 55+].sample,
    ethnicity: ethnicity_options.sample,
    password: "password123",
    password_confirmation: "password123",
    role_id: 2
  )

  puts "Created User ##{i + 1}: #{user.first_name} #{user.last_name} (#{user.email}) - #{user.phone_number}"
end

# Create 10 unique testimonials for random users
testimonials = [
  "AmanahRec opened my eyes to the beauty of nature and the importance of sustainability!",
  "Hiking with AmanahRec was a life-changing experience—highly recommended!",
  "Thanks to Hiking Hijabie, I found a community that shares my passion for nature.",
  "AmanahRec's events are always well-organized and meaningful.",
  "I learned so much about environmental stewardship through AmanahRec.",
  "Hiking Hijabie is the perfect combination of adventure and mindfulness.",
  "AmanahRec has helped me reconnect with nature in a deeper way.",
  "Hiking Hijabie is a true inspiration for women who love the outdoors.",
  "AmanahRec provided a safe and welcoming space for me to explore nature.",
  "Joining AmanahRec events is the highlight of my month!"
]

User.order("RANDOM()").limit(10).each_with_index do |user, index|
  testimonial = Testimonial.create!(
    text: testimonials[index],
    approved: [true, false].sample,
    user: user
  )

  puts "Created Testimonial ##{index + 1} for User #{user.id}: #{testimonial.text}"
end
