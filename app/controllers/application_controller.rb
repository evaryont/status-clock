require 'google/api_client'
require 'google/api_client/client_secrets'

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :user_signed_in?

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    # This generates a Google::APIClient::ClientSecrets object and converts it
    # into a Signet::OAuth2::Client object (Google's NIH OAuth library) that
    # handles the communication and secrets. (Access tokens, OAuth keys, etc.)
    #
    # The user must be signed in before calling this method. If not, they will
    # be redirected to root_url.
    def google_authorization
      authenticate_user!

      authorization = ::Google::APIClient::ClientSecrets.new({
        "web" => {
          "client_id" => ENV['OMNIAUTH_PROVIDER_KEY'],
          "client_secret" => ENV['OMNIAUTH_PROVIDER_SECRET'],
          #"redirect_uris" => ["http://localhost:3000", "http://evs.com:3000"],
          "auth_uri" => "https://accounts.google.com/o/oauth2/auth",
          "token_uri" => "https://accounts.google.com/o/oauth2/token"
        }
      }).to_authorization
      authorization.update_token!(
        :access_token => current_user.access_token,
        :refresh_token => current_user.refresh_token
      )
    end

    # Create a Google API client object.
    def google_api
      @google_api ||= Google::APIClient.new(:application_name => 'Status Clock', :application_version => '1.0.0')
      @google_api.authorization.clear_credentials!
      return @google_api
    end

    # Access google plus API, used to specify the method
    def google_plus
      @google_plus_api ||= google_api.discovered_api('plus', 'v1')
    end

    # Call a given Google API. Takes a hash of parameters:
    #
    #     {
    #       :api_method => google_plus.people.get,
    #       :parameters => {'userId' => 'me'}
    #     }
    #
    # If the user's access token is invalid, it will be refreshed once. If there
    # is still an error, check the resulting object's status for further
    # information.
    #
    # The user must be logged in before using this method.
    def google_api_call(parameters)
      parameters.merge!({ authorization: google_authorization })
      execute_method = lambda do
        google_api.execute(parameters)
      end
      method_result = execute_method.call
      if method_result.status == 401
        # The access token expired, so fetch a new one and
        # retry once.
        google_api.authorization.fetch_access_token!
        method_result = execute_method.call
      end

      return method_result
    end
end
