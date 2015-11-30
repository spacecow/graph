module Repo
  module RelationTypeMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def relation_types 
      url = URI "http://localhost:9292/api/relation_types?access_token=#{token}"
      response = Net::HTTP.get_response url
      JSON.parse(response.body)['relation_types']
    end
  end
end
