module Adhoq
  RSpec.describe Reporter::Xlsx, type: :model do
    context 'create xlsx report' do
      let(:report_data) do
        ex = Adhoq::AdhocExecution.new('xlsx', attributes_for(:adhoq_query, :greeting)[:query])

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
