module Adhoq
  RSpec.describe Query, type: :model do
    let(:query) { create(:adhoq_query) }

    specify { expect(query).to be }

    describe '#execute' do
      let(:query) { create(:adhoq_query, query: 'SELECT 42 AS answer') }

      specify { expect(query.execute).to eq Adhoq::Result.new(%w[answer], [[42]]) }
    end
  end
end
