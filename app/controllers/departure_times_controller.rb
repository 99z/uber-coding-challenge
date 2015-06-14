class DepartureTimesController < ApplicationController
	include DepartureTimesHelper
	def index
		# @ip = IP.new
		# @location = Geocoder.search(@ip.remote_ip(request.remote_ip))


		@lat = 37.362161
		@lon = -121.972694

		@station_list = Crack::XML.parse(HTTParty.get('http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V').body)
		closest_station(@station_list, @lat, @lon)
	end
end
