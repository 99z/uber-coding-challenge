module DepartureTimesHelper
  def distance(lat1, lon1, lat2, lon2)
	  Math.sqrt((lat2-lat1)**2 + (lon2-lon1)**2)
  end

  def closest_station(station_list, lat, lon)
    closest_station = {'distance' => 1000000}

  	station_list['root']['stations']['station'].each do |station|
      station['distance'] = distance(@lat, @lon, station['gtfs_latitude'].to_f, station['gtfs_longitude'].to_f)

      if station['distance'] < closest_station['distance']
        closest_station['name'] = station['name']
        closest_station['abbr'] = station['abbr']
        closest_station['latitude'] = station['gtfs_latitude']
        closest_station['longitude'] = station['gtfs_longitude']
        closest_station['distance'] = station['distance']
      end
  	end
    closest_station
  end
end
