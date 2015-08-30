module Repo
  module TaggingMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def new_tagging params={}
      Tagging.new params
    end

    def save_tagging tagging
      url = "http://localhost:9292/api/taggings?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      params = tagging.instance_values 
      response = http.post uri, {tagging:params}.to_query
      p response.body
      body = JSON.parse(response.body)['tagging']
      Tagging.new body
    end


  end
end
