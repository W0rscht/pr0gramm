require 'rest-client'
require 'uri'

class Pr0gramm
  class Requester
    module API

      def api_get(route = '', parameter = {}, request_data = {})

        request_data = {
          accept: :json,
        }.merge(request_data)

        if parameter
          request_data[:params] = parameter
        end
        if @cookies
          request_data[:cookies] = @cookies
        end

        @response = RestClient.get "#{@api_url}#{route}", request_data
        @cookies  = @response.cookies

        JSON.parse @response.to_str
      end

      def api_post(route = '', parameter = {}, request_data = {})

        request_data = {
          :accept => :json,
        }.merge( request_data )

        if ( @cookies )
          request_data[:cookies] = @cookies
        end

        @response = RestClient.post "#{@api_url}#{route}", parameter, request_data
        @cookies  = @response.cookies

         JSON.parse @response.to_str
      end

      def login(username, password)

        if @session
          logout
        end

        fail "Can't login while still logged in as '#{session[:name]}'" if @session

        login_result = api_post( '/user/login', { name: username, password: password } )

        fail "User '#{username}' is banned." if login_result['ban']

        fail "Login for user '#{username}' failed." if !login_result['success']

        cookies_to_session
      end

      def logout

        return if !@session

        logout_result = api_post( '/user/logout', { id: @session[:id], _nonce: @session[:id][0..16] } )

        # TODO: Improve error handling
        return if !logout_result['success']

        @session = nil
      end

      private

      def cookies_to_session
        # TODO: Move to session?
        session_cookie = JSON.parse URI.unescape( @cookies['me'] )

        @session = {
          id:    session_cookie['id'],
          name:  session_cookie['n'],
          paid:  session_cookie['paid'],
          pp:    session_cookie['pp'], # TODO: ?
        }

        @session[:admin] = session_cookie['a'] == 1 ? true : false;

        flags = session_cookie['flags']
        if flags
          flags = Pr0gramm::Flags.array( flags )
        end
        @session[:flags] = flags
      end

    end
  end
end