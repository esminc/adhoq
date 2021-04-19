require 'csv'

module Adhoq
  RSpec.describe Reporter::Csv, type: :model do
    describe '.mime_type' do
      specify { expect(Adhoq::Reporter::Csv.mime_type).to eq 'text/csv; charset=UTF-8' }
    end

    context 'create xlsx report' do
      let(:report_data) do
        ex = Adhoq::AdhocExecution.new('csv', attributes_for(:adhoq_query, :greeting)[:query])

        Adhoq::Reporter.generate(ex)
      end

      specify do
        expect(CSV.parse(report_data.read)).to eq [
          %w[name description],
          ['hello', 'English greeting message']
        ]
      end
    end

    describe 'CSV configuration' do
      let(:report_body) {
        [
          %w(ab cd ef),
          %w(gh ij kl)
        ]
      }
      let(:report_header) {
        %w(1 2 3)
      }
      let(:adhoq_result) {
        Adhoq::Result.new(report_header, report_body)
      }
      let(:reporter) {
        Adhoq::Reporter::Csv.new(adhoq_result)
      }

      describe 'row separator' do
        let(:row_sep) { "\r\n" }

        before do
          @before_row_sep = Adhoq.config.csv_row_separator
          Adhoq.config.csv_row_separator = row_sep
        end

        after do
          Adhoq.config.csv_row_separator = @before_row_sep
        end

        specify do
          report_result = reporter.build_report.read
          expect(CSV.parse(report_result, row_sep: row_sep)).to eq([report_header, *report_body])
        end
      end

      describe 'column separator' do
        let(:col_sep) { "\t" }

        before do
          @before_col_sep = Adhoq.config.csv_column_separator
          Adhoq.config.csv_column_separator = col_sep
        end

        after do
          Adhoq.config.csv_column_separator = @before_col_sep
        end

        specify do
          report_result = reporter.build_report.read
          expect(CSV.parse(report_result, col_sep: col_sep)).to eq([report_header, *report_body])
        end
      end
    end
  end
end
