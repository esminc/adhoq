module Adhoq
  RSpec.describe Reporter::Xlsx, type: :model do
    context 'create xlsx report' do
      let(:query) { 'SELECT "hello" AS name ,"English greeting message" AS description' }
      let(:report_data) do
        ex = Adhoq::AdhocExecution.new('xlsx', query)

        Adhoq::Reporter.generate(ex)
      end

      specify do
        expect(report_data.read).to have_values_in_xlsx_sheet([
          %w[name description],
          ['hello', 'English greeting message']
        ])
      end
    end
  end
end
