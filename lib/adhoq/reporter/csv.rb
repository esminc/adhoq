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

        csv_option = {}
        csv_option[:row_sep] = Adhoq.config.csv_row_separator    if Adhoq.config.csv_row_separator
        csv_option[:col_sep] = Adhoq.config.csv_column_separator if Adhoq.config.csv_column_separator

        csv  = CSV.new(file, csv_option)

        csv << @result.header
        @result.rows.each {|row| csv << row }

        file.tap(&:rewind)
      end
    end
  end
end
