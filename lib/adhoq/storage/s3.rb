require 'fog'

module Adhoq
  module Storage
    class S3
      def initialize(bucket, fog_options = {})
        @bucket = bucket
        @s3     = Fog::Storage.new({provider: 'AWS'}.merge(fog_options))
      end

      def identifier
        "s3://#{@bucket}"
      end

      def store(suffix = nil, seed = Time.now, &block)
        calculate_identifier(suffix, seed).tap do |identifier|
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

      private

      def directory
        return @directory if @directory

        @directory = @s3.directories.get(@bucket) || @s3.directories.create(key: @bucket, public: false)
      end

      def calculate_identifier(suffix, seed)
        dirname, fname_seed = ['%Y-%m-%d', '%H%M%S.%L'].map {|f| seed.strftime(f) }

        basename = "%s_%05d%s" % [fname_seed, Process.pid, suffix]

        [dirname, basename].join('/')
      end
    end
  end
end
