module Adhoq
  RSpec.describe Execution, :type => :model do
    before do
      storage = Adhoq::Storage::OnTheFly.new
      allow(Adhoq).to receive(:current_storage) { storage }
    end

    let(:execution) do
      query = create(:adhoq_query, query: 'SELECT name, description FROM adhoq_queries')
      query.execute!('xlsx')
    end

    specify { expect(execution.report).to be_on_the_fly }

    specify 'can get report only on execution' do
      expect(execution.report.data).to have_values_in_xlsx_sheet([
        ["name",    "description"],
        ["A query", "Simple simple SELECT"]
      ])

      # Accessable only once
      expect(execution.report.data).to be_nil
    end
  end
end
