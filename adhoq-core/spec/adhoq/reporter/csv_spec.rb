require 'csv'

module Adhoq
  RSpec.describe Reporter::Csv, type: :model do
    describe '.mime_type' do
      specify { expect(Adhoq::Reporter::Csv.mime_type).to eq 'text/csv; charset=UTF-8' }
    end

    context 'create xlsx report' do
      let(:query) { 'SELECT "hello" AS name ,"English greeting message" AS description' }
      let(:report_data) do
        ex = Adhoq::AdhocExecution.new('csv', query)

        Adhoq::Reporter.generate(ex)
      end

      specify do
        expect(CSV.parse(report_data.read)).to eq [
          %w[name description],
          ['hello', 'English greeting message']
        ]
      end
    end
  end
end

