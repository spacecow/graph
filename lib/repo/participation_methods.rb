module Repo
  module ParticipationMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def participation id
      url = URI "http://localhost:9292/api/participations/#{id}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      req = Net::HTTP::Get.new(
        uri.path, initheader = {'Content-Type' =>'application/json'})
      req['Accept'] = 'application/vnd.example.v1'
      req.body = {participations:token}.to_json
      response = http.request(req)
      body = JSON.parse response.body
      Participation.new body['participation']
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

    def update_participation id, params
      url = "http://localhost:9292/api/participations/#{id}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      req = Net::HTTP::Put.new(
        uri.path, initheader = {'Content-Type' =>'application/json'})
      req['Accept'] = 'application/vnd.example.v1'
      req.body = {participation:params}.merge(access_token:token).to_json
      http.request(req)
    end

    def delete_participation id
      url = "http://localhost:9292/api/participations/#{id}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port
      req = Net::HTTP::Delete.new(
        uri.path, initheader = {'Content-Type' =>'application/json'})
      req['Accept'] = 'application/vnd.example.v1'
      req.body = {access_token:token}.to_json
      response = http.request(req)
    end

  end
end
