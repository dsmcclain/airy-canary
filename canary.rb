#!/usr/bin/env ruby
require 'json'
require 'csv'

id = ARGV.first

response = `curl https://www.purpleair.com/json?show=#{id}`

sensor_data = JSON.parse(response)['results'].first
stats = JSON.parse(sensor_data['Stats'])

data_for_log = [Time.now, id, stats['v'], stats['v5']]

CSV.open('air_quality_log.csv', 'a+') do |file|
  file << ['Time', 'Sensor Id', 'Current Reading', '24hr Average'] if file.count.zero?
  file << data_for_log
end

if stats['v'] > 40
  output = Array[
    "===ALERT: HIGH READING FROM SENSOR #{id}===",
    "===#{Time.now.strftime('%m/%d/%Y at %I:%M %p')}===",
    "Current Reading: #{stats['v']}",
    "24hr Average: #{stats['v5']}"
  ]
  puts output
end
