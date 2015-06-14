class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def request_ip
    if Rails.env.development?
       response = HTTParty.get('http://api.hostip.info/get_html.php')
       ip = response.split("\n")
       ip.last.gsub /IP:\s+/, ''
     else
       request.remote_ip
     end
  end

end
