module Repo
  module UniverseMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def universe id
      url = URI "http://localhost:9292/api/universes/#{id}?access_token=#{token}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      Universe.new body['universe']
    end

    def all_universes
      url = URI "http://localhost:9292/api/universes?access_token=#{token}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      if body.include?('universes')
        body['universes'].map do |universe|
          Universe.new universe  
        end
      end
    end

    def new_universe params={}
      Universe.new params
    end

    def save_universe universe
      url = "http://localhost:9292/api/universes?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      params = universe.instance_values 
      response = http.post uri, {universe:params}.to_query
      body = JSON.parse(response.body)['universe']
      if response.code == "200"
        Universe.new body
      else
        Universe.new(params).tap do |article|
          body.each do |key,val|
            article.errors.add(key, val)
          end
        end
      end
    end

  end
end
