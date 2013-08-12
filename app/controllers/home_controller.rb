class HomeController < ApplicationController
  def index
    if current_user
      @profile = google_api_call({
        api_method: google_plus.people.get,
        parameters: { 'userId' => 'me' }
      })
      @profile = @profile.data unless @profile

      @latest_post = google_api_call({
        api_method: google_plus.activities.list,
        parameters: { 'userId' => 'me', 'collection' => 'public' }
      })
      @latest_post = @latest_post.data.items.select do |google_plus_post|
        google_plus_post.verb == "checkin"
      end.first unless @latest_post
    end
  end
end
