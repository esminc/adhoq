module Adhoq
  module Storage
    class FogStorage
      def store(suffix = nil, seed = Time.now, &block)
        Adhoq::Storage.with_new_identifier(suffix, seed) do |identifier|
          io = yield
          io.rewind

          directory.files.create(key: identifier, body: io, public: false)
        end
      end

      def get(identifier)
        get_raw(identifier).body
      end

      def get_raw(identifier)
        directory.files.head(identifier)
      end
    end
  end
end
