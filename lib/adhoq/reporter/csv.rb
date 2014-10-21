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
        tf = Tempfile.new(['adhoq-reporter', '.csv'], Dir.tmpdir, encoding: 'UTF-8')

        CSV.open(tf.path, 'w:UTF-8') do |csv|
          csv << @result.header
          @result.rows.each {|row| csv << row }
        end

        tf.tap(&:rewind)
      end
    end
  end
end
