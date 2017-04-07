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
    response = self.class.get('https://www.bloc.io/api/v1/mentors/' + mentor_id.to_s + '/student_availability', @headers)
    mentor_schedule = []
    response.parsed_response.each do |entry|
      if entry['booked'] == true
        start = entry['starts_at']
        finish = entry['ends_at']
        mentor_schedule.push(starts_at: finish, ends_at: start)
      end
    end
    return mentor_schedule
  end

  def get_checkpoint(checkpoint_id)
    # checkpoint number that worked for me was 2265
    id = checkpoint_id

    response = self.class.get('https://www.bloc.io/api/v1/checkpoints/' + id.to_s, @headers)

    @checkpoint = response.parsed_response

  end

  def get_roadmap(roadmaps_id)
    # roadmap number that works for this is 38
    id = roadmaps_id

    response = self.class.get('https://www.bloc.io/api/v1/roadmaps/' + id.to_s, @headers)

    @roadmap = response.parsed_response
  end

  def get_messages(page_no)

    params = @headers.clone
    params["body"] = {page: page_no}

    response = self.class.get('https://www.bloc.io/api/v1/message_threads' , params)

  end

  def create_message

    params = @headers.clone
    params[:body] = {
        'sender': "cuchumino@gmail.com",
        'recipient_id': 523730,
        'token': "66d124d3-79bb-40dd-8311-66f5419fb0ff",
        'subject': "Breakfast is important",
        'stripped-text': "Arguably the most important meal of the day. Never skip it. I highly recommend it."
    }

    puts params

    store = self.class.post('https://www.bloc.io/api/v1/messages', params)

    begin
      store.inspect
    rescue => e
      puts "Rescued #{e.inspect}"
    end

    puts store
  end

end
