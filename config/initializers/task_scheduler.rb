require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

scheduler.every '20m' do
   require "net/http"
   require "uri"
   url = 'http://myfxprofits.herokuapp.com'
   Net::HTTP.get_response(URI.parse(url))
end