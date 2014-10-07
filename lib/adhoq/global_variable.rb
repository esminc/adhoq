require 'monitor'

module Adhoq
  module GlobalVariable
    def self.extended(base)
      base.extend MonitorMixin
    end

    def current_storage
      synchronize {
        @current_storage ||= setup_storage(*Adhoq::Engine.config.storage)
      }
    end

    private

    # TODO Implement S3
    def setup_storage(type, *args)
      unless type == :local_file
        raise NotImplementedError
      end

      Adhoq::Storage::LocalFile.new(*args)
    end
  end
end
