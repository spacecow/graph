module Repo
  module StepMethods

    def token
      "90bc68f143f6b5fea3c0b6cedd5784e6ac61248ca39aa87372922d99eb4f8395"
    end

    def new_step params={}; Step.new params end

    def save_step step
      url = "http://localhost:9292/api/steps?access_token=#{token}"
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port 
      params = step.instance_values 
      response = http.post uri, {step:params}.to_query
      body = JSON.parse(response.body)['step']
      Step.new body
    end

  end
end
