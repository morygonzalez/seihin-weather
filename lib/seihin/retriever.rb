module Seihin
  class AuthenticationError < StandardError; end

  class Retriever
    class << self
      def execute
        @client = Atmo::Api.new

        unless @client.authenticate
          raise AuthenticationError, 'Authentication Failed!'
        end

        data = get_data
        result = format(data)
        close_file
        puts result
      end

      private

      def get_data
        data = @client.get_station_data
        store_cache(data)
        data
      rescue Faraday::ConnectionFailed
        restore_cache
      end

      def cache_file
        tmp_dir = File.expand_path(File.join(File.dirname(__FILE__), '../../tmp'))
        Dir.mkdir(tmp_dir) unless Dir.exist?(tmp_dir)
        cache_path = "#{tmp_dir}/cache"
        @cache_file ||= File.open(cache_path, 'w')
      end

      def restore_cache
        if test('m', cache_file) > Time.now - 15 * 60
          cache_file.read
        end
      end

      def store_cache(data)
        cache_file.write(data)
      end

      def close_file
        cache_file.close
      end

      def format(data)
        formatter = Formatter.new(data)
        formatter.format
      end
    end
  end
end
