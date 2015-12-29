module Adhoq
  RSpec.describe Query, type: :model do
    describe "#parameters" do
      it "returns query parameter Array of Hash" do
        query = Query.new(query: "SELECT * FROM users where created_at > '$time' AND activated = ${activated}")
        expect(query.parameters).to eq [
          "time",
          "activated",
        ]
      end
    end

    describe "#substitute_query" do
      it "returns query string with parameter binding" do
        query = Query.new(query: "SELECT * FROM users where created_at > '$time' AND activated = ${activated}")
        substitute = query.substitute_query({
          time: "2010-10-01 10:00:00",
          activated: "1",
        })
        expect(substitute).to eq "SELECT * FROM users where created_at > '2010-10-01 10:00:00' AND activated = 1"
      end

      context "query doesn't need parameter" do
        it "returns query string" do
          query = Query.new(query: "SELECT * FROM users")
          substitute = query.substitute_query({})
          expect(substitute).to eq "SELECT * FROM users"
        end
      end
    end
  end
end
