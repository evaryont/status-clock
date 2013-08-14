class TilesController < ApplicationController
  # This is simply used as an HTTPS->HTTP proxy. No niceness like caching to
  # limit hits on the OSM servers. Sorry!
  #
  # Assumes GET /tiles/:s/:z/:x/:y.png, does a 301 (permanent) redirect to OSM
  def proxy
    redirect_to "http://#{params[:s]}.tile.openstreetmap.org/#{params[:z]}/#{params[:x]}/#{params[:y]}.png", status: 301
  end
end
