require 'net/http'

#This scripts takes a file having http endpoints list (one endpoint per line)
#Accepts credentails for basic authentication
#Diplays output over console as well as captures output in file named results

print "Enter Server FQDN i.e. myserver.com: "
SERVER_NAME = gets.chomp()
puts "Using port: 8080"
PORT="8080"
print "Enter Username: "
USERNAME = gets.chomp()
print "Enter Password: "
PASSWORD=gets.chomp()

#File named endpoints.input should exist in current working directory
ENDPOINTS_LIST="endpoints.input"

#Read endpoints from file named "endpoints.input"
endpoints = IO.readlines(ENDPOINTS_LIST)

#File to write result
output = File.open("results", "w")
#Navigate through endpoints list and capture response
endpoints.each do |endpoint|
  puts "******************************************************"
  #Write to a file in parallel
  output << "******************************************************"
  puts "Endpoint: #{endpoint}"
  output << "Endpoint: #{endpoint}"
  
  uri = URI("http://#{SERVER_NAME}:#{PORT}/#{endpoint}")
  req = Net::HTTP::Get.new(uri)
  
  req.basic_auth "#{USERNAME}", "#{PASSWORD}"
  res = Net::HTTP.start(uri.hostname, uri.port) { |http|
    http.request(req)
  }
  
  puts res.body
  output << res.body
  puts "******************************************************"
  output << "******************************************************"
end
#Closing ouput file
output.close
