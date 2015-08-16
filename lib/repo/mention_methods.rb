module Repo
  module MentionMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def new_mention params={}
      Mention.new params
    end

    def save_mention mention
      url = "http://localhost:9292/api/mentions?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      params = mention.instance_values 
      response = http.post uri, {mention:params}.to_query
      body = JSON.parse(response.body)['note']
      p body
      Mention.new body
    end

  end
end

