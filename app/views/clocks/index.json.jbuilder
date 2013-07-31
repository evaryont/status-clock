json.array!(@clocks) do |clock|
  json.extract! clock, :user_id, :status_id
  json.url clock_url(clock, format: :json)
end
