module Repo
  module EventMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def event id
      url = URI "http://localhost:9292/api/events/#{id}?access_token=#{token}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      Event.new body['event']
    end

    def new_event params={}; Event.new params end

    def events universe_id:
      url = URI "http://localhost:9292/api/events?access_token=#{token}&universe_id=#{universe_id}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      body['events'].map{|event| Event.new event}
    end

    def save_event event
      url = "http://localhost:9292/api/events?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      params = event.instance_values 
      response = http.post uri, {event:params}.to_query
      body = JSON.parse(response.body)['event']
      Event.new body
    end

  end
end
