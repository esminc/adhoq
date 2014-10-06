require 'axlsx'

module Adhoq
  class Report
    class XlsxReporter
      def initialize(result)
        @result = result
      end

      def build_report
        Axlsx::Package.new.tap {|xlsx|
          xlsx.workbook.add_worksheet do |sheet|
            sheet.add_row @result.header
            @result.rows.each {|row| sheet.add_row row }
          end
        }.to_stream
      end
    end
  end
end
