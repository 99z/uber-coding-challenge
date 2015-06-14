class DepartureTimesController < ApplicationController
	def index
		@ip_address = IP.new.remote_ip(request.remote_ip)
	end
end
