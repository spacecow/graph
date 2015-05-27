module Repo
  module ArticleMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
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

  end
end
