require 'json'

module Adhoq
  RSpec.describe Reporter::Json, type: :model do
    describe '.mime_type' do
      specify { expect(Adhoq::Reporter::Json.mime_type).to eq 'application/json' }
    end

    context 'create xlsx report' do
      let(:query) { 'SELECT "hello" AS name ,"English greeting message" AS description' }
      let(:report_data) do
        ex = Adhoq::AdhocExecution.new('json', query)

        Adhoq::Reporter.generate(ex)
      end

      specify do
        expect(JSON.parse(report_data.read)).to eq [
          {
            'name'        => 'hello',
            'description' =>  'English greeting message'
          }
        ]
      end
    end
  end
end


