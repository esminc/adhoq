module Adhoq
  RSpec.describe Executor::ConnectionWrapper, type: :model do
    describe '.select' do
      specify 'Do not reflect write access' do
        expect {
          Executor::ConnectionWrapper.new.select(<<-INSERT_SQL.strip_heredoc)
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
