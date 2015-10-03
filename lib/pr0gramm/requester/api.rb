require 'rest-client'
require 'uri'

class Pr0gramm
  class Requester
    module API
      def api_get(route = '', parameter = {}, request_data = {})
        request_data = {
          accept: :json
        }.merge(request_data)

        request_data[:params] = parameter if parameter
        request_data[:cookies] = @cookies if @cookies

        @response = RestClient.get "#{@api_url}#{route}", request_data

        JSON.parse @response.to_str
      end

      def api_post(route = '', parameter = {}, request_data = {})
        request_data = {
          accept: :json
        }.merge(request_data)

        request_data[:cookies] = @cookies if @cookies

        url       = "#{@api_url}#{route}"
        @response = RestClient.post url, parameter, request_data

        JSON.parse @response.to_str
      end

      def login(username, password)
        logout if @session

        fail "Still logged in as '#{session[:name]}'" if @session

        login_request(username, password)
        login_cookies
      end

      def logout
        return unless @session

        parameter = {
          id: @session[:id],
          _nonce: @session[:nonce]
        }

        logout_result = api_post('/user/logout', parameter)

        # TODO: Improve error handling
        return unless logout_result['success']

        @session = nil
      end

      private

      def cookies_to_session(session_cookie)
        @session = {
          id:    session_cookie['id'],
          nonce: session_cookie['id'][0..15],
          name:  session_cookie['n'],
          paid:  session_cookie['paid'],
          pp:    session_cookie['pp'], # TODO: ?
        }

        @session[:admin] = session_cookie['a'] == 1 ? true : false

        return unless session_cookie['flags']

        @session[:flags] = Pr0gramm::Flags.array(session_cookie['flags'])
      end

      def login_request(username, password)
        parameter = {
          name:     username,
          password: password
        }

        login_result = api_post('/user/login', parameter)

        fail "User '#{username}' is banned." if login_result['ban']

        fail "Login as '#{username}' failed." unless login_result['success']
      end

      def login_cookies
        fail 'Missing login cookies.' unless @response.cookies
        fail 'Empty login cookies.' if @response.cookies.empty?

        @cookies = @response.cookies

        cookies_to_session(JSON.parse URI.unescape(@cookies['me']))
      end
    end
  end
end
