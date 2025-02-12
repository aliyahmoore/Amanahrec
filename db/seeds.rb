# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Role.create!(id: 1, name: "admin") unless Role.exists?(id: 1)
Role.create!(id: 2, name: "user") unless Role.exists?(id: 2)

Activity.create!([
  {
    title: "Hiking Hijabie Snowshoeing",
    description: "Enjoy a guided snowshoeing experience at Eastman Nature Center.",
    start_date: "2023-01-21 10:00 AM",
    end_date: "2023-01-21 12:30 PM",
    location: "Eastman Nature Center",
    cost: nil,
    capacity: 20,
    what_to_bring: "Winter gear, water bottle",
    rules: "Dress appropriately for the cold weather",
    notes: "Cashapp$AmanahRec",
    early_access_for_members: true,
    early_access_days: 7,
    general_registration_start: "2022-12-21 10:00 AM"
  },
  {
    title: "Pottery Workshop",
    description: "Learn the basics of pottery in a hands-on workshop.",
    start_date: "2023-12-08 5:15 PM",
    end_date: "2023-12-08 8:15 PM",
    location: "Silverwood Park, 2500 County Rd E, St Anthony, MN 55421",
    cost: 30,
    capacity: 15,
    what_to_bring: "Apron, enthusiasm",
    rules: "Follow instructor guidelines",
    notes: "Limited spots available",
    early_access_for_members: true,
    early_access_days: 7,
    general_registration_start: "2023-11-08 5:15 PM"
  },
  {
    title: "Amanah Rec Game Night",
    description: "16+ event featuring games, coffee or tea, and pastries.",
    start_date: "2023-06-07 18:00",
    end_date: "2024-06-07 21:00",
    location: "1736 Penn Ave N, Minneapolis, MN 55411",
    cost: nil,
    capacity: 30,
    what_to_bring: "Good vibes and a love for games",
    rules: "Respectful conduct required",
    notes: "Recurring event, check for upcoming dates",
    early_access_for_members: true,
    early_access_days: 7,
    general_registration_start: "2023-05-07 18:00"
  },
  {
    title: "Amanah Rec Grand Opening",
    description: "Food will be catered from Oasis Restaurant. We look forward to seeing you there!",
    start_date: "2024-06-01 10:30 AM",
    end_date: "2024-06-01 3:00 PM",
    location: "The Loppet Foundation, 1221 Theodore Wirth Parkway, Minneapolis MN",
    cost: nil,
    capacity: 100,
    what_to_bring: "Appetite and excitement",
    rules: "Family-friendly event",
    notes: "Come celebrate with us!",
    early_access_for_members: false,
    early_access_days: nil,
    general_registration_start: "2024-05-01 10:30 AM"
  },
      {
    title: "Mommie & Me Bouldering",
    description: "Best Play Areas for Kids\nHiking Hijabie Discount will make it $12 each for all kids & members \n$15 for all nonmembers ages 18+\nRegular prices are $13 for 13 and under\n$18 for 14-20 year olds\n$20 for $21+",
    start_date: "2023-01-27 18:00",
    end_date: "2023-01-27 20:00",
    location: "1433 West River Rd N, Minneapolis, MN 55411",
    cost: 12,
    capacity: 30,
    what_to_bring: "Comfortable clothing, climbing shoes (provided if needed)",
    rules: "All participants must sign a waiver",
    notes: "Discount available for members",
    general_registration_start: "2023-01-20 10:00"
  },
  {
    title: "Hiking Day Trip",
    description: "Please bring lunch & snack. We will pray duhur & asir then have lunch at the park",
    start_date: "2024-07-15 10:30",
    end_date: "2024-07-15 14:30",
    location: "Minneopa State Park, Gadwall Road, Mankato, MN 56001",
    cost: 0,
    capacity: 50,
    what_to_bring: "Lunch, snacks, water, prayer mat",
    rules: "Respect nature, leave no trace",
    notes: "Group will meet at the main entrance",
    general_registration_start: "2024-07-01 09:00"
  },
  {
    title: "Hiking Ummah & Hiking Hijabie",
    description: "This 5.8-mile loop trail near Hudson, WI is generally considered a moderately challenging route & it takes an average of 2 hours to complete. Please make sure you're able to hike for a minimum of 2 hours.",
    start_date: "2023-07-29 10:00",
    end_date: "2023-07-29 13:00",
    location: "Hudson, WI",
    cost: 5,
    capacity: 40,
    what_to_bring: "Water, Lunch, and/or snacks.",
    rules: "You will need a parking sticker or day pass",
    notes: "It's 45 min to an hour drive. Please plan accordingly",
    general_registration_start: "2023-07-15 08:00"
  },
  {
    title: "Amanah Rec Game Night",
    description: "16+ Comes with (Coffee or tea) & Pastry",
    start_date: "2023-07-21 17:30",
    end_date: "2024-06-07 20:30",
    location: "1736 Penn Ave N, Minneapolis, MN 5411",
    cost: 10,
    capacity: 20,
    what_to_bring: "Board games (optional)",
    rules: "No outside food or drinks",
    notes: "Enjoy a fun night with friends",
    general_registration_start: "2023-07-10 09:00"
  },
  {
    title: "Hiking Hijabie Iftar",
    description: "Followed by traweeh prayer",
    start_date: "2023-04-14 18:00",
    end_date: "2023-04-14 21:00",
    location: "Local Mosque - Exact location TBD",
    cost: 0,
    capacity: 50,
    what_to_bring: "Water bottle, prayer mat",
    rules: "Observe fasting etiquette",
    notes: "Save the date",
    general_registration_start: "2023-04-01 08:00"
  },
  {
    title: "Hiking Ummah & Dhkir Walk with Imam Mowlid",
    description: "Spiritual hiking event with guided dhikr",
    start_date: "2024-05-05 05:15",
    end_date: "2024-05-05 08:00",
    location: "2498 River Pointe Lane, Minneapolis MN 55411",
    cost: 0,
    capacity: 30,
    what_to_bring: "Comfortable walking shoes, water",
    rules: "Respectful conduct required",
    notes: "Early morning walk with spiritual reflection",
    general_registration_start: "2024-04-20 10:00"
  },
  {
    title: "Free Family Printmaking",
    description: "Nature Printmaking\nFind out about the fascinating world of fungi and what makes these organisms entirely different from plants and animals! Inspired by your observations, design, and print colorful images using simple printmaking techniques and tools.\n\nProgram will be set in our white oak classroom - Located across the main parking lot from our Visitor Center. Sponsored by Parks to People",
    start_date: "2023-06-10 12:30",
    end_date: "2023-06-10 15:30",
    location: "Silverwood Park, 2500 County Rd E, St Anthony, MN 55421",
    cost: 0,
    capacity: 30,
    what_to_bring: "Apron or old clothes",
    rules: "Children must be accompanied by an adult",
    notes: "Three Rivers Park District",
    general_registration_start: "2023-06-01 09:00"
  }
])
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
    approved: [ true, false ].sample,
    user: user
  )

  puts "Created Testimonial ##{index + 1} for User #{user.id}: #{testimonial.text}"
end
