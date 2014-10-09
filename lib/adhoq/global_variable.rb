require 'monitor'

module Adhoq
  module GlobalVariable
    def self.extended(base)
      base.extend MonitorMixin
    end

    def current_storage
      synchronize {
        @current_storage ||= setup_storage(*Adhoq.config.storage)
      }
    end

    def configure(&block)
      yield config
    end

    def config
      @config ||= Adhoq::Configuration.new
    end

    private

    def setup_storage(type, *args)
      klass =
        case type
        when :local_file then Adhoq::Storage::LocalFile
        when :s3         then Adhoq::Storage::S3
        else
          raise NotImplementedError
        end

      klass.new(*args)
    end
  end
end
