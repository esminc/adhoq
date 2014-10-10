module Adhoq
  RSpec.describe Executor, type: :model do
    context 'create xlsx report' do
      let(:executor) do
        Executor.new('SELECT 42 AS answer')
      end

      specify { expect(executor.execute).to eq Adhoq::Result.new(%w[answer], [[42]]) }
    end

    describe '.select' do
      specify 'Do not reflect write access' do
        expect {
          Executor.select(<<-INSERT_SQL.strip_heredoc)
            INSERT INTO "adhoq_queries"
            ("description", "name", "query", "updated_at", "created_at")
            VALUES
            ("description", "name", "SELECT 1", "NOW", "NOW")
          INSERT_SQL
        }.not_to change(Adhoq::Query, :count)
      end
    end
  end
end
