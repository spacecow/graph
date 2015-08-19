module Repo
  module NoteMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def note id
      url = URI "http://localhost:9292/api/notes/#{id}?access_token=#{token}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      Note.new body['note']
    end

    def new_note params={}
      Note.new params
    end

    def save_note note
      url = "http://localhost:9292/api/notes?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      params = note.instance_values 
      response = http.post uri, {note:params}.to_query
      body = JSON.parse(response.body)['note']
      if response.code == "200"
        Note.new body
      else
        Note.new(params).tap do |note|
          body.each do |key,val|
            note.errors.add(key, val)
          end
        end
      end
    end

  end
end
