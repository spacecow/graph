module Repo
  module ArticleMentionMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def article_mention id
      url = URI "http://localhost:9292/api/article_mentions/#{id}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      req = Net::HTTP::Get.new(
        uri.path, initheader = {'Content-Type' =>'application/json'})
      req['Accept'] = 'application/vnd.example.v1'
      req.body = {access_token:token}.to_json
      response = http.request(req)
      body = JSON.parse response.body
      ArticleMention.new body['article_mention']
    end

    def new_article_mention params; ArticleMention.new params end

    def save_article_mention params
      url = "http://localhost:9292/api/article_mentions"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      req = Net::HTTP::Post.new(
        uri.path, initheader = {'Content-Type' =>'application/json'})
      req['Accept'] = 'application/vnd.example.v1'
      req.body = {article_mention:params}.merge(access_token:token).to_json
      http.request(req)
    end

    def update_article_mention id, params
      url = "http://localhost:9292/api/article_mentions/#{id}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      req = Net::HTTP::Put.new(
        uri.path, initheader = {'Content-Type' =>'application/json'})
      req['Accept'] = 'application/vnd.example.v1'
      req.body = {article_mention:params}.merge(access_token:token).to_json
      http.request(req)
    end

  end
end
