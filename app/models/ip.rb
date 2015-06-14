class IP < ActiveRecord::Base
	# Get the users current IP address
	# and hard code local machine in order to make this useful.
	# I needed to use a parameter here because 'request' is only 
	# accessable in the controller.
	def remote_ip(ip)
		if ip == '127.0.0.1' || ip == '::1'
      # Hard coded remote address
      '68.174.130.168'
    else
      ip
    end
	end
end
