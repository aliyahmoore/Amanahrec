# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

MediaMention.create!([
  {
    name: "Hiking Hijabie: Hiking group helps connect Muslim community to the Great Outdoors",
    organization_name: "Fox9",
    published_date: "2023-10-18",
    description: "ABC",
    link: "https://www.fox9.com/news/hiking-group-helps-connect-muslim-community-to-the-great-outdoors"
  },
  {
    name: "Hiking group for Muslim women breaks barriers as hundreds flock to the outdoors",
    organization_name: "Sahan Journal",
    published_date: "2024-11-12",
    description: "ABC",
    link: "https://sahanjournal.com/arts-culture/muslim-hiking-groups-minnesota-women-somali-owned/"
  },
  {
    name: "Hiking Hijabie: How this Minneapolis business owner is making outdoor clothing more inclusive",
    organization_name: "Kare11",
    published_date: "2025-01-07",
    description: "ABC",
    link: "https://www.kare11.com/article/news/local/news-at-noon/hiking-minneapolis-business-owner-making-outdoor-clothing-more-inclusive/89-0b985477-3850-45d8-88a5-d516734d10f1"
  },
  {
    name: "Scarves over headscarves, Muslim women’s outdoors group tackles snow tubing in Minnesota",
    organization_name: "AP News",
    published_date: "2025-01-08",
    description: "ABC",
    link: "https://apnews.com/article/islam-muslim-women-hijabs-outdoor-adventures-minnesota-cold-7c29def2171de0f41f60936c4568e011"
  },
  {
    name: "Empowering Muslim Women in Minnesota with Hiking Hijabie",
    organization_name: "Mn Upstream",
    published_date: "2024-03-11",
    description: "ABC",
    link: "https://mnupstream.org/loving-where-we-live-with-nasireen-habib/"
  },
  {
    name: "Hidden Gems: Meet Nasrieen Habib of Amanah Rec Project",
    organization_name: "Voyage Minnesota",
    published_date: "2024-08-21",
    description: "ABC",
    link: "https://voyageminnesota.com/interview/hidden-gems-meet-nasrieen-habib-of-amanah-rec-project"
  },
  {
    name: "Hiking group for Muslim women breaks barriers as hundreds flock to the outdoors",
    organization_name: "Star Tribune",
    published_date: "2024-11-16",
    description: "ABC",
    link: "https://www.startribune.com/hiking-group-for-muslim-women-breaks-barriers-as-hundreds-flock-to-the-outdoors/601181812"
  },
  {
    name: "Group Breaks Barriers in Minnesota and Beyond",
    organization_name: "About Islam",
    published_date: "2024-11-17",
    description: "ABC",
    link: "https://aboutislam.net/muslim-issues/n-america/muslim-womens-hiking-group-breaks-barriers-in-minnesota-and-beyond/"
  },
  {
    name: "Twin Cities Muslim Women’s Hiking Group Breaks Barriers",
    organization_name: "Barlaguna",
    published_date: "2024-11-16",
    description: "ABC",
    link: "https://www.barlaguna.it/2024/11/17/62173"
  },
  {
    name: "Minneapolis: Group Builds Community, Connection for Muslim Women Outdoors",
    organization_name: "Iqna",
    published_date: "2024-11-13",
    description: "ABC",
    link: "https://iqna.ir/en/news/3490675/minneapolis-group-builds-community-connection-for-muslim-women-outdoors"
  },
  {
    name: "From hijabs to hiking: Muslim women embrace the great outdoors",
    organization_name: "Africa News",
    published_date: "2024-10-01",
    description: "ABC",
    link: "https://www.africanews.com/2025/01/10/from-hijabs-to-hiking-muslim-women-embrace-the-great-outdoors/"
  },
  {
    name: "Un groupe de randonnées de femmes musulmanes brise les barrières au Minnesota et au-delà",
    organization_name: "Histoire Et Chronique",
    published_date: "2024-11-17",
    description: "ABC",
    link: "https://www.histoire-et-chronique.fr/2024/11/17/un-groupe-de-randonnees-de-femmes-musulmanes-brise-les-barrieres-au-minnesota-et-au-dela/"
  },
  {
    name: "Scarves over headscarves, Muslim women’s outdoors group tackles snow tubing in Minnesota",
    organization_name: "Washington Times",
    published_date: "2025-01-08",
    description: "ABC",
    link: "https://www.washingtontimes.com/news/2025/jan/8/scarves-headscarves-muslim-women-outdoors-group-mi/"
  },
  {
    name: "Hiking group for Muslim women breaks barriers as hundreds flock to the outdoors",
    organization_name: "Wisconsin Muslim Journal",
    published_date: "2024-11-29",
    description: "ABC",
    link: "https://wisconsinmuslimjournal.org/https-sahanjournal-com-arts-culture-muslim-hiking-groups-minnesota-women-somali-owned/"
  },
  {
    name: "Hiking Hijabie: How This Minneapolis Business Owner Is Making Outdoor Clothing More Inclusive",
    organization_name: "Minneapolis Media Town News",
    published_date: "2024-01-07",
    description: "ABC",
    link: "https://minneapolimedia.town.news/g/coon-rapids-mn/n/286512/hiking-hijabie-how-minneapolis-business-owner-making-outdoor-clothing"
  }
])
