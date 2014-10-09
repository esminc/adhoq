module Adhoq
  RSpec.describe Storage, type: :model do
    describe Storage::LocalFile do
      tempdir = __dir__ + '/../../tmp/adhoq_storage.test'

      after(:all) do
        FileUtils.rm_rf(tempdir)
      end

      let(:storage) { Storage::LocalFile.new(tempdir) }

      let(:identifier) do
        storage.store('.txt') {|file, ident| file.puts 'Hello adhoq!' }
      end

      specify { expect(storage.get(identifier).read).to eq "Hello adhoq!\n" }
    end

    describe Storage::S3, :fog_mock do
      let(:storage) { Storage::S3.new('my-adhoq-bucket', aws_access_key_id: 'key_id', aws_secret_access_key: 'access_key') }

      let(:identifier) do
        storage.store('.txt') {|file, ident| file.puts 'Hello adhoq!' }
      end

      specify { expect(storage.get(identifier).read).to eq "Hello adhoq!\n" }
    end
  end
end
