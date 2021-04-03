require 'uri'
require 'net/http'
require 'openssl'
require 'json'
module ElevatorMedia 
    class Streamer
        def self.getContent(input) 
            url = URI("https://covid-19-data.p.rapidapi.com/report/country/name?date=2020-04-01&name=#{input}&date-format=YYYY-MM-DD&format=json")
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
            request = Net::HTTP::Get.new(url)
            request["x-rapidapi-key"] = 'ad79b44e5bmsh2b6210a3ef29223p1a5ee5jsncc406e22144a'
            request["x-rapidapi-host"] = 'covid-19-data.p.rapidapi.com'
            response = http.request(request)
            result = JSON.parse(response.read_body)    
            puts"-------------"
            puts result
            puts"-------------"
            return("<div>#{result['province']}</div>")
        end
    end 
end