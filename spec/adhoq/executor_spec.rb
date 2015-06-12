module Adhoq
  RSpec.describe Executor, type: :model do
    context 'create xlsx report' do
      let(:executor) do
        Executor.new('SELECT 42 AS answer')
      end

      specify { expect(executor.execute).to eq Adhoq::Result.new(%w[answer], [[42]]) }
    end
  end
end
