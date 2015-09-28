module Adhoq
  module Storage
    autoload 'FogStorage', 'adhoq/storage/fog_storage'
    autoload 'LocalFile',  'adhoq/storage/local_file'
    autoload 'S3',         'adhoq/storage/s3'
    autoload 'OnTheFly',   'adhoq/storage/on_the_fly'

    def with_new_identifier(suffix = nil, seed = Time.now)
      dirname, fname_seed = ['%Y-%m-%d', '%H%M%S.%L'].map {|f| seed.strftime(f) }

      basename = "%s_%05d%s" % [fname_seed, Process.pid, suffix]

      [dirname, basename].join('/').tap {|id| yield id }
    end
    module_function :with_new_identifier
  end
end
