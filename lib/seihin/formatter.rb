module Seihin
  class Formatter
    def initialize(data)
      @data = data
    end

    def format
      station_name = @data['body']['devices'][0]['station_name']
      outside = @data['body']['devices'][0]['modules'][0]['dashboard_data']
      station = @data['body']['devices'][0]['dashboard_data']

      <<-__EOS__
#{station_name}の気象情報をお届けします（#{Time.at(station['time_utc']).strftime('%F %R')}計測）
屋外気温 #{outside['Temperature']}°C
屋外湿度 #{outside['Humidity']}%
室内気温 #{station['Temperature']}°C
室内騒音 #{station['Noise']}dB
室内湿度 #{station['Humidity']}%
室内CO2濃度 #{station['CO2']}ppm
      __EOS__
    end
  end
end
