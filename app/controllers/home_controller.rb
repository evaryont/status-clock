class HomeController < ApplicationController
  def index
    if current_user
      @profile = google_api_call({
        api_method: google_plus.people.get,
        parameters: { 'userId' => 'me' }
      }).data

      @latest_post = google_api_call({
        api_method: google_plus.activities.list,
        parameters: { 'userId' => 'me', 'collection' => 'public' }
      }).data.items.first
    end
  end
end
