require 'httparty'
class Kele
  include HTTParty

  # @headers = { content_type: 'application/json' }

  def initialize(email, password)

    @options = { email: email, password: password }
  end

  def get_auth_token
    puts self.class.post('https://www.bloc.io/api/v1/sessions', query: @options)
  end

end
