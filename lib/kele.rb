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

    auth_token = stored.parsed_response['auth_token']
    @headers = {headers: {authorization: auth_token, content_type: 'application/json'}}

  end

  def get_me
    response = self.class.get('https://www.bloc.io/api/v1/users/me', @headers)
    @ruby_response = response.parsed_response
  end

  def get_mentor_availability(mentor_id)
    @body = {body: {id: mentor_id}}
    response = self.class.get('https://www.bloc.io/api/v1/mentors/' + mentor_id.to_s + '/student_availability', @headers)

    @mentor_schedule = response.parsed_response
  end
end
