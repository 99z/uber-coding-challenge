module DepartureTimesHelper
  def distance(lat1, lon1, lat2, lon2)
	  Math.sqrt((lat2-lat1)**2 + (lon2-lon1)**2)
  end

  def closest_station(station_list, lat, lon)
  	closest_station = {:distance => 0}
  	station_list['root']['stations']['station'].each do |station|
  		if distance(@lat, @lon, station['gtfs_latitude'].to_f, station['gtfs_longitude'].to_f) < closest_station[:distance]
  			dl
  		end
  	end
  end
end
