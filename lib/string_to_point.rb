# Craig Ulliott
# geocode a string, and return a Point
class String

  # sends this string to google geocoder, parses the response and returns a Point
  def to_point street_only = true
    begin
      address = self
      response = HTTParty.get('http://maps.googleapis.com/maps/api/geocode/json', :format => :json, :query => {:address => address, :sensor => 'false'})
      if street_only
        raise 'not enough accuracy from results' unless ["street_address", 'subpremise'].include? response["results"][0]["types"][0]
      end
      latlon = response["results"][0]["geometry"]["location"]
      return Point.from_x_y latlon["lng"], latlon["lat"]
    rescue Exception => e  
      return nil
    end
  end
  
end