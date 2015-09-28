module Adhoq
  module Storage
    class OnTheFly
      PREFIX = 'memory://adhoq-on-the-fly'

      attr_reader :identifier, :reports

      def initialize(id_base = Process.pid)
        @identifier = "#{PREFIX}-#{id_base}"
        @reports    = {}
      end

      def store(suffix = nil, seed = Time.now, &block)
        Adhoq::Storage.with_new_identifier(suffix, seed) do |identifier|
          @reports[identifier] = yield.tap(&:rewind)
        end
      end

      def direct_download?
        false
      end

      def get(identifier)
        if item = @reports.delete(identifier)
          item.read.tap { item.close }
        else
          nil
        end
      end
    end
  end
end
