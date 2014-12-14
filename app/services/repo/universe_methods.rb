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

    def new_universe
      Universe.new
    end

  end
end
