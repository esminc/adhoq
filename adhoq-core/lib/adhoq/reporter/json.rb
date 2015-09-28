require 'json'

module Adhoq
  module Reporter
    class Json

      def self.mime_type
        'application/json'
      end

      def initialize(result)
        @result = result
      end

      def build_report
        file = Tempfile.new(['adhoq-reporter', '.csv'], Dir.tmpdir, encoding: 'UTF-8')
        write_content!(file)

        file.tap(&:rewind)
      end

      private

      def write_content!(file)
        json_objects = @result.rows.map {|row| Hash[*@result.header.zip(row).flatten] }

        file.write(JSON.dump(json_objects))
      end
    end
  end
end
