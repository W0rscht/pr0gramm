require 'rest-client'
require 'uri'

class Pr0gramm

  class Requester

    attr_reader :session, :response

    def initialize(options)

      options = {
        url:      'pr0gramm.com',
        api_path: '/api',
        protocol: 'https',
      }.merge(options)

      @base_url = "#{options[:protocol]}://#{options[:url]}#{options[:api_path]}"
      @session  = nil

      # logout when destroying the object
      ObjectSpace.define_finalizer(self, method(:destructor))

      return if !options[:username] || !options[:password]

      login(options[:username], options[:password])
    end

    def get(route = '', parameter = {}, request_data = {})

      request_data = {
        accept: :json,
      }.merge(request_data)

      if parameter
        request_data[:params] = parameter
      end
      if @cookies
        request_data[:cookies] = @cookies
      end

      @response = RestClient.get "#{@base_url}#{route}", request_data
      @cookies  = @response.cookies

      JSON.parse @response.to_str
    end

    def post(route = '', parameter = {}, request_data = {})

      request_data = {
        :accept => :json,
      }.merge( request_data )

      if ( @cookies )
        request_data[:cookies] = @cookies
      end

      @response = RestClient.post "#{@base_url}#{route}", parameter, request_data
      @cookies  = @response.cookies

       JSON.parse @response.to_str
    end

    def login(username, password)

      if @session
        logout
      end

      fail "Can't login while still logged in as '#{session[:name]}'" if @session

      login_result = post( '/user/login', { name: username, password: password } )

      fail "User '#{username}' is banned." if login_result['ban']

      fail "Login for user '#{username}' failed." if !login_result['success']

      cookies_to_session
    end

    def logout

      return if !@session

      logout_result = post( '/user/logout', { id: @session[:id], _nonce: @session[:id][0..16] } )

      # TODO: Improve error handling
      return if !logout_result['success']

      @session = nil
    end

    def destructor(_object_id)
      logout
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