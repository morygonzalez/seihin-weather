module Seihin
  class Device
    include DeviceFormatter

    def initialize(device_data)
      @device_data = device_data
    end

    def station_name
      @device_data['station_name']
    end

    def outside
      @device_data['modules'][0]['dashboard_data']
    end

    def station
      @device_data['dashboard_data']
    end

    def station_time
      Time.at(station['time_utc'])
    end

    def outside_temperature_level
      case
      when outside['Temperature'] > 28
        :hot
      when outside['Temperature'] > 18
        :warm
      when outside['Temperature'] > 10
        :moderate
      when outside['Temperature'] > 3
        :cool
      else
        :cold
      end
    end

    def station_temperature_level
      case
      when station['Temperature'] > 27
        :hot
      when station['Temperature'] > 21
        :moderate
      when station['Temperature'] > 17
        :cool
      else
        :cold
      end
    end

    def station_co2_level
      case
      when station['CO2'] > 3000
        :danger
      when station['CO2'] > 2000
        :warning
      when station['CO2'] > 1000
        :caution
      else
        :moderate
      end
    end
  end
end
