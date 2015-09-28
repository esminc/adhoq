require 'csv'

module Adhoq
  module Reporter
    class Csv

      def self.mime_type
        'text/csv; charset=UTF-8'
      end

      def initialize(result)
        @result = result
      end

      def build_report
        file = Tempfile.new(['adhoq-reporter', '.csv'], Dir.tmpdir, encoding: 'UTF-8')
        csv  = CSV.new(file)

        csv << @result.header
        @result.rows.each {|row| csv << row }

        file.tap(&:rewind)
      end
    end
  end
end
