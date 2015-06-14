class DepartureTimesController < ApplicationController
	include DepartureTimesHelper
	def index
		ip = request_ip

		@location = Geocoder.search(ip)

		if @location.nil?
			@lat = 37.362161
			@long = -121.972694
		end

		@station_list = Crack::XML.parse(HTTParty.get('http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V').body)

		@distance = distance([@lat, @long], [37.765062, -122.419694])
	end
end
