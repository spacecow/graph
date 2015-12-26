module Repo
  module CitationMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def new_citation params; Citation.new params end

    def save_citation params
      url = "http://localhost:9292/api/citations"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      req = Net::HTTP::Post.new(
        uri.path, initheader = {'Content-Type' =>'application/json'})
      req['Accept'] = 'application/vnd.example.v1'
      req.body = {citation:params}.merge(access_token:token).to_json
      response = http.request(req)
    end

  end
end
