# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

10.times do
        user = User.create!(
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.unique.email,
          password: 'Password123!',  # Ensure this meets your password complexity rules
          phone_number: Faker::PhoneNumber.cell_phone_in_e164,
          gender: ['Male', 'Female', 'Non-Binary'].sample,
          ethnicity: ['White', 'Black or African American', 'Asian', 'American Indian or Alaska Native', 'Native Hawaiian or Other Pacific Islander', 'Hispanic or Latino', 'Other', 'Prefer not to say'].sample,
          approved: [true, false].sample,  # Random approval status
          age_range: ['18-25', '26-35', '36-45', '46-60', '60+'].sample,  # Random age range
          created_at: Time.now, 
          updated_at: Time.now
        )
        # Confirm the user immediately by setting confirmed_at
        user.update!(confirmed_at: Time.now)
      end