require 'fog/local'

module Adhoq
  module Storage
    class LocalFile < FogStorage
      attr_reader :root

      def initialize(root_path)
        path = Pathname.new(root_path)

        @fog = Fog::Storage.new(provider: 'Local', local_root: path.parent)
        @dir = path.basename.to_s
      end

      def identifier
        "file://#{[@fog.local_root, @dir].join('/')}"
      end

      private

      def directory
        @fog.directories.get(@dir) || @fog.directories.create(key: @dir)
      end
    end
  end
end
