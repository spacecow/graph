module Repo
  module ReferenceMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def reference id
      url = URI "http://localhost:9292/api/references/#{id}?access_token=#{token}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      Reference.new body['reference']
    end

    def new_reference params={}
      Reference.new params
    end

    def save_reference reference
      url = "http://localhost:9292/api/references?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      params = Hash[*[:note_id, :image_data, :url].map{|e| [e,reference.send(e)]}.flatten]
      response = http.post uri, {reference:params}.to_query
      body = JSON.parse(response.body)['reference']
      Reference.new body
    end

  end
end

