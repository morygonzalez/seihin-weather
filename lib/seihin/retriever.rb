module Seihin
  class AuthenticationError < StandardError; end

  class Retriever
    class << self
      def execute
        @client = Atmo::Api.new

        unless @client.authenticate
          raise AuthenticationError, 'Authentication Failed!'
        end

        data   = @client.get_station_data
        result = format(data)
        puts result
      end

      private

      def format(data)
        formatter = Formatter.new(data)
        formatter.format
      end
    end
  end
end
