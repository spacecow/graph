module Repo
  module ArticleMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def all_articles
      url = URI "http://localhost:9292/api/articles?access_token=#{token}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      if body.include?('articles')
        body['articles'].map do |article|
          Article.new article  
        end
      end
    end

    def new_article params={}
      Article.new params
    end

    def save_article article
      url = "http://localhost:9292/api/articles?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      params = article.instance_values 
      http.post uri, {article:params}.to_query
    end

  end
end
