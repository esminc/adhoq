module Adhoq
  module Storage
    class Cache
      attr_reader :identifier

      def initialize(cache, prefix = "", expire = 300)
        @cache = cache
        @identifier = @prefix = prefix
        @expire = expire
      end

      def store(suffix = nil, seed = Time.now, &block)
        Adhoq::Storage.with_new_identifier(suffix, seed) do |identifier|
          @cache.write(@prefix + identifier, yield.read, expires_in: @expire)
        end
      end

      def direct_download?
        false
      end

      def get(identifier)
        @cache.read(@prefix + identifier)
      end
    end
  end
end
