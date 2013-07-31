json.array!(@statuses) do |status|
  json.extract! status, :text, :lcd, :user_id
  json.url status_url(status, format: :json)
end
