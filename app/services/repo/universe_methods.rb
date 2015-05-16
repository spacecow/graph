module Repo
  module UniverseMethods

    def all_universes
      url = URI 'http://localhost:9292/universes'
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
      url = 'http://localhost:9292/universes'
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      params = universe.instance_values 
      http.post uri, {universe:params}.to_query
    end

  end
end
