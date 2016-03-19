module Seihin
  module DeviceFormatter
    def colorize(value)
      case value
      when :hot, :danger
        'red'
      when :warning
        'purple'
      when :warm
        'orange'
      when :caution
        'yellow'
      when :moderate
        'green'
      when :cool
        'blue'
      when :cold
        'cadetblue'
      end
    end

    def station_temperature_color
      colorize(station_temperature_level)
    end

    def outside_temperature_color
      colorize(outside_temperature_level)
    end

    def station_co2_color
      colorize(station_co2_level)
    end

    def formatted_time
      station_time.strftime('%F %R')
    end

    def format
      if ENV['BitBar']
        <<-EOS
#{station_name}
---
屋外気温 #{outside['Temperature']}°C | color=#{outside_temperature_color}
室内気温 #{station['Temperature']}°C | color=#{station_temperature_color}
屋外湿度 #{outside['Humidity']}%
室内湿度 #{station['Humidity']}%
室内騒音 #{station['Noise']}dB
室内CO2濃度 #{station['CO2']}ppm | color=#{station_co2_color}
#{formatted_time} 計測 | href=https://my.netatmo.com/app/station
        EOS
      else
        <<-EOS
#{station_name}の気象情報をお届けします（#{formatted_time}計測）
屋外気温 #{outside['Temperature']}°C
屋外湿度 #{outside['Humidity']}%
室内気温 #{station['Temperature']}°C
室内騒音 #{station['Noise']}dB
室内湿度 #{station['Humidity']}%
室内CO2濃度 #{station['CO2']}ppm
        EOS
      end
    end
  end
end
