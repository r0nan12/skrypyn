ENV['RAILS_ENV'] = "development"
set :output,  "#{path}/log/cron.log"

 every 10.minutes do
   runner ' Order.clear'
 end
