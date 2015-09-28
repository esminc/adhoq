module Adhoq
  RSpec.describe Report, type: :model do
    context 'create xlsx report' do
      let(:query) do
        create(:adhoq_query, query: 'SELECT name, description FROM adhoq_queries')
      end

      let(:report) do
        execution = query.execute!('xlsx')
        execution.report
      end

      specify do
        expect(report.data).to have_values_in_xlsx_sheet([
          %w[name description],
          [query.name, query.description]
        ])
      end

      specify do
        expect(report.name).to match /#{query.name}\.[\d\-]+\.xlsx/
      end
    end
  end
end
