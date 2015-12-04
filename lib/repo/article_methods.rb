module Repo
  module ArticleMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def article id
      url = URI "http://localhost:9292/api/articles/#{id}?access_token=#{token}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      Article.new body['article']
    end

    def articles universe_id:
      url = URI "http://localhost:9292/api/articles?access_token=#{token}&universe_id=#{universe_id}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      body['articles'].map{|article| Article.new article}
    end

    def new_article params={}
      Article.new params
    end

    def save_article article
      url = "http://localhost:9292/api/articles?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      params = article.instance_values 
      response = http.post uri, {article:params}.to_query
      body = JSON.parse(response.body)['article']
      if response.code == "200"
        Article.new body
      else
        Article.new(params).tap do |article|
          body.each do |key,val|
            article.errors.add(key, val)
          end
        end
      end
    end

    def update_article article, params
      url = "http://localhost:9292/api/articles/#{article.id}?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      response = http.put uri, {article:params}.to_query
      body = JSON.parse(response.body)['article']
      Article.new body
    end

  end
end
