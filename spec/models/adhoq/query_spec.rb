module Adhoq
  RSpec.describe Query, type: :model do
    describe "#parameters" do
      it "returns query parameter Array of Hash" do
        query = Query.new(query: "SELECT * FROM users where created_at > $time::datetime AND activated = $activated::int")
        expect(query.parameters).to eq [
          {name: "time", type: "datetime"},
          {name: "activated", type: "int"},
        ]
      end
    end

    describe "#sanitized_query" do
      it "returns query string with parameter binding" do
        query = Query.new(query: "SELECT * FROM users where created_at > $time::datetime AND activated = $activated::int")
        sanitized = query.sanitized_query({
          time: {value: "2010-10-1 10:00:00", type: "datetime"},
          activated: {value: "1", type: "int"},
        })
        expect(sanitized).to eq "SELECT * FROM users where created_at > '2010-10-01 10:00:00.000000' AND activated = 1"
      end

      context "query doesn't need parameter" do
        it "returns query string" do
          query = Query.new(query: "SELECT * FROM users")
          sanitized = query.sanitized_query({})
          expect(sanitized).to eq "SELECT * FROM users"
        end
      end
    end
  end
end
