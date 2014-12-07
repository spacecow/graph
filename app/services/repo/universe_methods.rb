module Repo
  module UniverseMethods

    def all_universes
      response = Net::HTTP.get_response(URI('http://localhost:9292/universes'))
      JSON.parse(response.body)["universes"].map do |universe|
        Universe.new universe  
      end
    end

    def new_universe
      Universe.new
    end

  end
end
