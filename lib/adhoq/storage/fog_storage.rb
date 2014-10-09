module Adhoq
  module Storage
    class FogStorage

      def store(suffix = nil, seed = Time.now, &block)
        Adhoq::Storage.with_new_identifier(suffix, seed) do |identifier|
          Tempfile.open('adhoq-storage-s3') do |file|
            file.binmode

            yield file, identifier
            file.rewind

            directory.files.create(key: identifier, body: file, public: false)
          end
        end
      end

      # FIXME Should change interface
      def get(identifier)
        Tempfile.open('adhoq-storage-s3').tap do |file|
          file.binmode
          file.write get_raw(identifier).body
          file.rewind
        end
      end

      def get_raw(identifier)
        directory.files.head(identifier)
      end
    end
  end
end
