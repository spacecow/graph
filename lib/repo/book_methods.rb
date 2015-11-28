module Repo
  module BookMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def books universe_id:universe_id
      url = URI "http://localhost:9292/api/books?access_token=#{token}&universe_id=#{universe_id}"
      response = Net::HTTP.get_response url
      JSON.parse(response.body)['books']
      #['Cryptonomicon']
    end
  end
end
