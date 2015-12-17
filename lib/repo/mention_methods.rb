module Repo
  module MentionMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def new_mention params={}; Mention.new params end

    def save_mention params
      url = "http://localhost:9292/api/mentions"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      req = Net::HTTP::Post.new(
        uri.path, initheader = {'Content-Type' =>'application/json'})
      req['Accept'] = 'application/vnd.example.v1'
      req.body = {mention:params}.merge(access_token:token).to_json
      response = http.request(req)
      body = JSON.parse(response.body)['mention']
      Mention.new body
    end

  end
end
