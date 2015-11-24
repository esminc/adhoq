module Adhoq
  RSpec.describe Storage, type: :model do
    describe Storage::LocalFile do
      tempdir = __dir__ + '/../../tmp/adhoq_storage.test'

      after(:all) do
        FileUtils.rm_rf(tempdir)
      end

      let(:storage) { Storage::LocalFile.new(tempdir) }

      let(:identifier) do
        storage.store('.txt') { StringIO.new("Hello adhoq!\n") }
      end

      specify { expect(storage.get(identifier)).to eq "Hello adhoq!\n" }
    end

    describe Storage::S3, :fog_mock do
      context 'access key' do
        let(:storage) { Storage::S3.new('my-adhoq-bucket', aws_access_key_id: 'key_id', aws_secret_access_key: 'access_key') }
  
        let(:identifier) do
          storage.store('.txt') { StringIO.new("Hello adhoq!\n") }
        end
  
        specify { expect(storage.get(identifier)).to eq "Hello adhoq!\n" }
      end

      context 'iam profile' do
        let(:storage) { Storage::S3.new('my-adhoq-bucket', use_iam_profile: true) }
  
        let(:identifier) do
          storage.store('.txt') { StringIO.new("Hello adhoq!\n") }
        end
  
        specify { expect(storage.get(identifier)).to eq "Hello adhoq!\n" }
      end

    end

    describe Storage::OnTheFly do
      let(:storage) { Storage::OnTheFly.new }

      let!(:identifier) do
        storage.store('.txt') { StringIO.new("Hello adhoq!\n") }
      end

      specify { expect(storage.get(identifier)).to eq "Hello adhoq!\n" }

      specify do
        expect { storage.get(identifier) }.to change { storage.reports.size }.by(-1)
      end
    end
  end
end
