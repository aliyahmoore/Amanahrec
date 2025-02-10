# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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
    general_registration_start: "2022-12-21 10:00 AM",
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
    general_registration_start: "2023-11-08 5:15 PM",
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
    general_registration_start: "2023-05-07 18:00",
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
    general_registration_start: "2024-05-01 10:30 AM",
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

MediaMention.create!([
  {
    name: "Hiking Hijabie: Hiking group helps connect Muslim community to the Great Outdoors",
    organization_name: "Fox9",
    published_date: "2023-10-18",
    link: "https://www.fox9.com/news/hiking-group-helps-connect-muslim-community-to-the-great-outdoors"
  },
  {
    name: "Hiking group for Muslim women breaks barriers as hundreds flock to the outdoors",
    organization_name: "Sahan Journal",
    published_date: "2024-11-12",
    link: "https://sahanjournal.com/arts-culture/muslim-hiking-groups-minnesota-women-somali-owned/"
  },
  {
    name: "Hiking Hijabie: How this Minneapolis business owner is making outdoor clothing more inclusive",
    organization_name: "Kare11",
    published_date: "2025-01-07",
    link: "https://www.kare11.com/article/news/local/news-at-noon/hiking-minneapolis-business-owner-making-outdoor-clothing-more-inclusive/89-0b985477-3850-45d8-88a5-d516734d10f1"
  },
  {
    name: "Scarves over headscarves, Muslim women’s outdoors group tackles snow tubing in Minnesota",
    organization_name: "AP News",
    published_date: "2025-01-08",
    link: "https://apnews.com/article/islam-muslim-women-hijabs-outdoor-adventures-minnesota-cold-7c29def2171de0f41f60936c4568e011"
  },
  {
    name: "Empowering Muslim Women in Minnesota with Hiking Hijabie",
    organization_name: "Mn Upstream",
    published_date: "2024-03-11",
    link: "https://mnupstream.org/loving-where-we-live-with-nasireen-habib/"
  },
  {
    name: "Hidden Gems: Meet Nasrieen Habib of Amanah Rec Project",
    organization_name: "Voyage Minnesota",
    published_date: "2024-08-21",
    link: "https://voyageminnesota.com/interview/hidden-gems-meet-nasrieen-habib-of-amanah-rec-project"
  },
  {
    name: "Hiking group for Muslim women breaks barriers as hundreds flock to the outdoors",
    organization_name: "Star Tribune",
    published_date: "2024-11-16",
    link: "https://www.startribune.com/hiking-group-for-muslim-women-breaks-barriers-as-hundreds-flock-to-the-outdoors/601181812"
  },
  {
    name: "Group Breaks Barriers in Minnesota and Beyond",
    organization_name: "About Islam",
    published_date: "2024-11-17",
    link: "https://aboutislam.net/muslim-issues/n-america/muslim-womens-hiking-group-breaks-barriers-in-minnesota-and-beyond/"
  },
  {
    name: "Twin Cities Muslim Women’s Hiking Group Breaks Barriers",
    organization_name: "Barlaguna",
    published_date: "2024-11-16",
    link: "https://www.barlaguna.it/2024/11/17/62173"
  },
  {
    name: "Minneapolis: Group Builds Community, Connection for Muslim Women Outdoors",
    organization_name: "Iqna",
    published_date: "2024-11-13",
    link: "https://iqna.ir/en/news/3490675/minneapolis-group-builds-community-connection-for-muslim-women-outdoors"
  },
  {
    name: "From hijabs to hiking: Muslim women embrace the great outdoors",
    organization_name: "Africa News",
    published_date: "2024-10-01",
    link: "https://www.africanews.com/2025/01/10/from-hijabs-to-hiking-muslim-women-embrace-the-great-outdoors/"
  },
  {
    name: "Un groupe de randonnées de femmes musulmanes brise les barrières au Minnesota et au-delà",
    organization_name: "Histoire Et Chronique",
    published_date: "2024-11-17",
    link: "https://www.histoire-et-chronique.fr/2024/11/17/un-groupe-de-randonnees-de-femmes-musulmanes-brise-les-barrieres-au-minnesota-et-au-dela/"
  },
  {
    name: "Scarves over headscarves, Muslim women’s outdoors group tackles snow tubing in Minnesota",
    organization_name: "Washington Times",
    published_date: "2025-01-08",
    link: "https://www.washingtontimes.com/news/2025/jan/8/scarves-headscarves-muslim-women-outdoors-group-mi/"
  },
  {
    name: "Hiking group for Muslim women breaks barriers as hundreds flock to the outdoors",
    organization_name: "Wisconsin Muslim Journal",
    published_date: "2024-11-29",
    link: "https://wisconsinmuslimjournal.org/https-sahanjournal-com-arts-culture-muslim-hiking-groups-minnesota-women-somali-owned/"
  },
  {
    name: "Hiking Hijabie: How This Minneapolis Business Owner Is Making Outdoor Clothing More Inclusive",
    organization_name: "Minneapolis Media Town News",
    published_date: "2024-01-07",
    link: "https://minneapolimedia.town.news/g/coon-rapids-mn/n/286512/hiking-hijabie-how-minneapolis-business-owner-making-outdoor-clothing"
  }
])
