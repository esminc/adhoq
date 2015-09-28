require 'axlsx'

module Adhoq
  module Reporter
    class Xlsx

      def self.mime_type
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      end

      def initialize(result)
        @result = result
      end

      def build_report
        xlsx = Axlsx::Package.new
        write_result!(xlsx)

        xlsx.to_stream
      end

      private

      def write_result!(xlsx)
        xlsx.workbook.add_worksheet do |sheet|
          sheet.add_row @result.header
          @result.rows.each {|row| sheet.add_row row }
        end
      end
    end
  end
end
