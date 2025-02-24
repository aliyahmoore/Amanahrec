# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

About.create!(
  mission: "Our mission is to revive spiritual values of environmental sustainability through recreational activities and
          provide support to those impacted by climate change, guided by our core spiritual principles.",
  vision: "Our vision is to foster a sustainable future for people and planet by upholding the trust to protect and
          care for creation through meaningful exploration and appreciation rooted in stewardship.",
  founder: "Nasrieen Habib is a humanitarian entrepreneur and community leader deeply committed to sustainability, cultural heritage, and inclusivity. As the founder of EcoJariyah and Amanah Recreational Project, Nasrieen blends Islamic principles with environmental action, encouraging her community to embrace sustainable, eco-conscious lifestyles.
          EcoJariyah's product lines, including Hiking Hijabi and Hiking Ummah, highlight ethical and climate-neutral goods while supporting global initiatives such as well-building and orphan sponsorship. With a passion for the outdoors, Nasrieen also founded Hiking Hijabie, an inclusive space for Muslim women to explore nature while fostering environmental stewardship. Her efforts have led the group to grow to over 750 members, offering activities that range from hiking and kayaking to bouldering and camping, giving Muslim women and families a safe, supportive way to experience nature. Nasrieen's broader work includes organizing zero-waste events, sitting on the board of ARAHA, and advocating for sustainable development in marginalized communities. Rooted in her African heritage and her faith, Nasrieen's journey is a testament to her dedication to social justice, community empowerment, and bridging the gap between her Minnesota community and global sustainability efforts. Through her leadership and advocacy, she inspires others to live mindfully, embracing an Eco Sunnah Lifestyle that uplifts both people and the planet."
)
