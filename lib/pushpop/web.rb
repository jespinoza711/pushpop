require 'sinatra/base'
require 'json'

module Pushpop
  class Web

    def app
      Sinatra::Application
    end

    def routes
      @routes ||= []
    end

    def add_route(url, job)

      if url[0] != '/'
        url = "/#{url}"
      end

      raise "Route #{url} is already set up as a webhook" if routes.include?(url)

      runner = lambda do
        response = self.instance_eval(&job.webhook_proc)

        if response
          {
            status: 'success',
            job: job.name
          }.to_json
        else
          {
            status: 'failed',
            job: job.name,
            message: 'webhook step did not pass'
          }.to_json
        end
      end
      
      Sinatra::Application.get  url, &runner
      Sinatra::Application.post url, &runner
      Sinatra::Application.put  url, &runner

      routes.push(url)
    
    end
  end
end
