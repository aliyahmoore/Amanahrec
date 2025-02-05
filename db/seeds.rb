# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Event.create!([
  {
    title: "Free Camping Prep Night",
    description: "Dinner: PB&J or Turkey Sandwich and Lemonade\nBreakfast: oatmeal or PB&J and Somalia tea.\nYou're welcome to bring your own dinner, breakfast & snacks. Please bring your own s'mores.\nThree Rivers will provide: tent, sleeping mats, lamp, roasting sticks & cooking stove.\nPlease bring anything you need to be comfortable. I recommend air mattress, pillow, blanket, toiletries, tea, coffee, and snacks. We will play games so bring your favorite camping games.",
    start_date: "2023-07-30 16:00",
    end_date: "2023-08-01 08:00",
    location: "Sumac Knoll Group Campsite, Bloomington, MN 55438",
    general_registration_start: "2023-07-01",
    rsvp_deadline: "2023-07-23 16:00",
    cost: 0,
    childcare: true,
    sponsors: "Three Rivers Park District",
    capacity: 20
  },
  {
    title: "Duluth Fall Trip",
    description: "Accommodations & Breakfast. Lutsen Adventure Day Pass $60 (group discount for $55 possible). It will be a separate payment, so whoever wants can get single rides at Lutsen online.\nShared beds make it affordable. Sisters will share rooms & brothers will share rooms. If you want your own bed, it's double the price. Families of 5-6 can share a suite with pullout sofa. Only 5 available at $850.\n\nTransportation: Will create group chat for people to coordinate carpooling. Everyone is responsible for finding their own rides & using the group chat to find a ride. Please chip in for gas and parking if carpooling.\n\nThis is a hiking trip. Must be able to hike & walk for 2 hours a day. No exceptions.",
    start_date: "2023-10-06",
    end_date: "2023-10-08",
    location: "Duluth, MN",
    general_registration_start: "2023-09-01",
    rsvp_deadline: "2023-09-30",
    cost: 215,
    childcare: false,
    capacity: 15
  },
  {
    title: "Glacier National Park Hiking Hijabie Road Trip 18+",
    description: "National Parks Road Trip:\n1. Theodore Roosevelt National Park, ND\n2. Glacier National Park, MT\n3. Badlands National Park, SD\n\nTransportation, hotel & glamp camp included. Shared beds to make it affordable. Text to book a spot.\n\nThis is a hiking trip. Must be able to hike and walk for 3-5 hours a day. No exceptions.\n\nAll sales are final & non-refundable. You may sell your spot to someone else, but there will be no refunds.",
    start_date: "2024-08-31",
    end_date: "2024-09-05",
    location: "Theodore Roosevelt National Park, ND\n Glacier National Park, MT\nBadlands National Park, SD",
    general_registration_start: "2024-08-01",
    rsvp_deadline: "2024-08-15",
    cost: 700,
    childcare: true,
    capacity: 10
  }
])
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
