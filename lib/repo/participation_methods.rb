module Repo
  module ParticipationMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def new_participation params; Participation.new params end

    def save_participation participation
      url = "http://localhost:9292/api/participations?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      params = participation.instance_values 
      response = http.post uri, {participation:params}.to_query
      body = JSON.parse(response.body)['participation']
      Participation.new body
    end

  end
end
