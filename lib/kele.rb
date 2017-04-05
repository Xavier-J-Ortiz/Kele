require 'httparty'
require 'json'
class Kele
  include HTTParty
  include JSON

  # @headers = { content_type: 'application/json' }

  def initialize(email, password)

    @options = { email: email, password: password }
  end

  def get_auth_token
    stored = self.class.post('https://www.bloc.io/api/v1/sessions', query: @options)
    begin
      stored.inspect
    rescue => e
      puts "Rescued #{e.inspect}"
    end

    @auth_token = stored.parsed_response['auth_token']

  end

  def get_me

    response = self.class.get('https://www.bloc.io/api/v1/users/me', headers: { authorization: @auth_token })

    ruby_response = response.parsed_response

  end
end
