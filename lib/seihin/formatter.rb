module Seihin
  class Formatter
    def initialize(data)
      @data = data
    end

    def devices
      @data['body']['devices']
    end

    def format
      devices.inject('') do |result, device_data|
        device = Device.new(device_data)
        result << device.format
      end
    end
  end
end
