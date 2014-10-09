module Adhoq
  RSpec.describe GlobalVariable, type: :model do
    def reset_storage_config(*storage_config)
      Adhoq.instance_variable_set('@current_storage', nil)
      Adhoq.config.storage = storage_config
    end

    around(:each) do |example|
      begin
        original_config = Adhoq.config.storage
        example.run
      ensure
        reset_storage_config(*original_config)
      end
    end

    context 'config.storage = [:local_file, ....]' do
      before do
        reset_storage_config(:local_file, Rails.root + "/tmp/adhoq/#{Rails.env}")
      end

      specify do
        expect(Adhoq.current_storage).to be_instance_of Adhoq::Storage::LocalFile
      end
    end

    context 'config.storage = [:s3, ....]' do
      before do
        reset_storage_config(:s3, 'my-bucket-name', aws_access_key_id: 'key-id', aws_secret_access_key: 'secret', region: 'paris-01')
      end

      specify do
        expect(Adhoq.current_storage).to be_instance_of Adhoq::Storage::S3
      end
    end
  end
end
