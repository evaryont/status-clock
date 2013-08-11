json.array!(@clocks) do |clock|
  json.extract! clock, :users_id, :statuses_id
  json.url clock_url(clock, format: :json)
end
