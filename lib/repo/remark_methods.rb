module Repo
  module RemarkMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def remark id, remarkable_id:
      url = URI "http://localhost:9292/api/remarks/#{id}?access_token=#{token}"
      response = Net::HTTP.get_response url
      body = JSON.parse response.body
      Remark.new body['remark'].merge(remarkable_id:remarkable_id)
    end

    def new_remark params={}; Remark.new params end

    def save_remark params, event_id
      url = "http://localhost:9292/api/remarks?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      response = http.post uri, {event_id:event_id, remark:params}.to_query
      body = JSON.parse(response.body)['remark']
      Remark.new body
    end

    def update_remark id, params
      url = "http://localhost:9292/api/remarks/#{id}?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      response = http.put uri, {remark:params}.to_query
      body = JSON.parse(response.body)['remark']
      Remark.new body
    end

    def delete_remark id
      url = "http://localhost:9292/api/remarks/#{id}?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port
      req = Net::HTTP::Delete.new(
        uri.path, initheader = {'Content-Type' =>'application/json'})
      req['Accept'] = 'application/vnd.example.t1'
      http.request(req)
    end

  end
end
