json.extract! source, :id, :fname, :lname, :byear, :dyear, :bio, :created_at, :updated_at
json.url source_url(source, format: :json)
