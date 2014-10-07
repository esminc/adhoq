module Adhoq
  module Storage
    class LocalFile
      attr_reader :root

      def initialize(root_path)
        @root = Pathname.new(root_path)
      end

      def store(suffix = nil, seed = Time.now, &block)
        calculate_identifier(suffix, seed).tap do |identifier|
          mkpath!(identifier)

          (@root + identifier).open('w:BINARY') do |file|
            yield file, identifier
          end
        end
      end

      def get(identifier)
        (@root + identifier).open('r:BINARY')
      end

      private

      def calculate_identifier(suffix, seed)
        dirname, fname_seed = ['%Y-%m-%d', '%H%M%S.%L'].map {|f| seed.strftime(f) }

        basename = "%s_%05d%s" % [fname_seed, Process.pid, suffix]

        identifier = [dirname, basename].join('/')
      end

      def mkpath!(identifier)
        dir = identifier.split('/').first
        (@root + dir).mkpath
      end
    end
  end
end
