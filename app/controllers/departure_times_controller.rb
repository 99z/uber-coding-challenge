class DepartureTimesController < ApplicationController
	def index
		@ip_address = request.location
		@station_list = Crack::XML.parse(HTTParty.get('http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V').body)
	end
end
