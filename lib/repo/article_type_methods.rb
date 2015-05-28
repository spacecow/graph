module Repo
  module ArticleTypeMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def article_types 
      url = URI "http://localhost:9292/api/article_types?access_token=#{token}"
      response = Net::HTTP.get_response url
      JSON.parse(response.body)['article_types']
    end
  end
end
