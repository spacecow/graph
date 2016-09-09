module Repo
  module RelationMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def relation id
      url = URI "http://localhost:9292/api/relations/#{id}?access_token=#{token}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      Relation.new body['relation']
    end

    def new_relation params={}; Relation.new params end

    def save_relation params
      url = "http://localhost:9292/api/relations?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      response = http.post uri, {relation:params}.to_query
      body = JSON.parse(response.body)['relation']
      Relation.new body
    end

    def invert_relation id
      url = "http://localhost:9292/api/relations/#{id}/invert"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      req = Net::HTTP::Put.new(
        uri.path, initheader = {'Content-Type' =>'application/json'})
      req['Accept'] = 'application/vnd.example.v1'
      req.body = {access_token:token}.to_json
      response = http.request req
      body = JSON.parse(response.body)['relation']
      Relation.new body
    end

    def update_relation id, params
      url = "http://localhost:9292/api/relations/#{id}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      req = Net::HTTP::Put.new(
        uri.path, initheader = {'Content-Type' =>'application/json'})
      req['Accept'] = 'application/vnd.example.v1'
      req.body = {relation:params}.merge(access_token:token).to_json
      response = http.request(req)
      body = JSON.parse(response.body)['relation']
      Relation.new body
    end

  end
end
