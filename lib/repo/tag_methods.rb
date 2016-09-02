module Repo
  module TagMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def tag id
      url = URI "http://localhost:9292/api/tags/#{id}?access_token=#{token}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      Tag.new body['tag']
    end

    def tags universe_id 
      url = URI "http://localhost:9292/api/tags?access_token=#{token}&universe_id=#{universe_id}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      body['tags'].map{|tag| Tag.new tag}
    end

    def new_tag params; Tag.new params end

    def save_tag tag
      url = "http://localhost:9292/api/tags?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      params = tag.instance_values 
      response = http.post uri, {tag:params}.to_query
      body = JSON.parse(response.body)['tag']
      Tag.new body
    end

    def delete_tag id, params
      url = "http://localhost:9292/api/tags/#{id}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port
      req = Net::HTTP::Delete.new(
        uri.path, initheader = {'Content-Type' =>'application/json'})
      req['Accept'] = 'application/vnd.example.v1'
      req.body = {tag:params}.merge(access_token:token).to_json
      http.request(req)
    end


  end
end
