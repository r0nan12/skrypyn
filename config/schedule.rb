ENV['RAILS_ENV'] = "development"
set :output,  "#{path}/log/cron.log"

 every 20.minutes do
   runner ' Order.clear'
 end
