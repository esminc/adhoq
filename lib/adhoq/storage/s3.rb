require 'fog'

module Adhoq
  module Storage
    class S3 < FogStorage
      def initialize(bucket, s3_options = {})
        @bucket = bucket
        @direct_download = s3_options.delete(:direct_download)
        @s3     = Fog::Storage.new({provider: 'AWS'}.merge(s3_options))
      end

      def direct_download?
        @direct_download
      end

      def identifier
        "s3://#{@bucket}"
      end

      def get_url(identifier, options = {})
        get_raw(identifier).url(1.minutes.from_now.to_i, options)
      end

      private

      def directory
        return @directory if @directory

        @directory = @s3.directories.get(@bucket) || @s3.directories.create(key: @bucket, public: false)
      end
    end
  end
end
