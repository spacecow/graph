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
      uri = URI.parse url
      params = universe.instance_values 
      Net::HTTP.post_form uri, params
    end

  end
end
