json.extract! media_mention, :id, :name, :link, :published_date, :organization_name, :created_at, :updated_at
json.url media_mention_url(media_mention, format: :json)
