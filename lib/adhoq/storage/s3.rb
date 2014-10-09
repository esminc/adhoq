require 'fog'

module Adhoq
  module Storage
    class S3 < FogStorage
      def initialize(bucket, fog_options = {})
        @bucket = bucket
        @s3     = Fog::Storage.new({provider: 'AWS'}.merge(fog_options))
      end

      def identifier
        "s3://#{@bucket}"
      end

      private

      def directory
        return @directory if @directory

        @directory = @s3.directories.get(@bucket) || @s3.directories.create(key: @bucket, public: false)
      end
    end
  end
end
