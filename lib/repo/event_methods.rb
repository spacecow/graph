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

  end
end
