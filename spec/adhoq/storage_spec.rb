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
  end
end
