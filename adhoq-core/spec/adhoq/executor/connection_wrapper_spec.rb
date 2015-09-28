require 'active_support/core_ext/string'

module Adhoq
  RSpec.describe Executor::ConnectionWrapper, type: :model do
    describe '.select' do
      specify 'Do not reflect write access' do
        expect {
          Executor::ConnectionWrapper.new.select(<<-INSERT_SQL.strip_heredoc)
            INSERT INTO "users"
            ("name", "updated_at", "created_at")
            VALUES
            ("name", "NOW", "NOW")
          INSERT_SQL
        }.not_to change(User, :count)
      end
    end
  end
end
