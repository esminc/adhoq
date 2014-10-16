module Adhoq
  RSpec.describe Reporter::Xlsx, type: :model do
    context 'create xlsx report' do
      let(:report_data) do
        Adhoq::Reporter.generate(Adhoq::AdhocExecution.new('xlsx', <<-SQL.strip_heredoc))
          SELECT "hello" AS name ,"English greeting message" AS description
        SQL
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
