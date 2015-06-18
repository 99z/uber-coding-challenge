class DepartureTimesController < ApplicationController
	include DepartureTimesHelper
	def index
		# @ip = IP.new

		location = Geocoder.search(HTTParty.get('http://www.telize.com/ip').body)

		@lat = location.first.latitude
		@lon = location.first.longitude

		@station_list = Crack::XML.parse(HTTParty.get('http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V').body)

		@station_code = (params[:station_code] ? params[:station_code] : closest_station(@station_list, @lat, @lon)['abbr'])

		@departures = Crack::XML.parse(HTTParty.get("http://api.bart.gov/api/sched.aspx?cmd=stnsched&orig=#{@station_code}&date=now&key=MW9S-E7SL-26DU-VV8V&l=1").body)
	end
end
