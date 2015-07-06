require 'fog'

module Adhoq
  module Storage
    class S3 < FogStorage
      def initialize(bucket, s3_options = {})
        @bucket                  = bucket
        @direct_download         = s3_options.delete(:direct_download)
        @direct_download_options = s3_options.delete(:direct_download_options) || default_direct_download_options
        @s3 = Fog::Storage.new({provider: 'AWS'}.merge(s3_options))
      end

      def direct_download?
        @direct_download
      end

      def identifier
        "s3://#{@bucket}"
      end

      def get_url(report)
        get_raw(report.identifier).url(
          1.minutes.from_now.to_i,
          @direct_download_options.call(report)
        )
      end

      private

      def directory
        return @directory if @directory

        @directory = @s3.directories.get(@bucket) || @s3.directories.create(key: @bucket, public: false)
      end

      def default_direct_download_options
        proc do |report|
          {
            query: {
              'response-content-disposition' => "attachment; filename=\"#{name}\"",
              'response-content-type' => report.mime_type,
            }
          }
        end
      end
    end
  end
end
