class DepartureTimesController < ApplicationController
	def index
		ip = request_ip

		@ip_address = Geocoder.search(ip)
		@station_list = Crack::XML.parse(HTTParty.get('http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V').body)
	end
end
