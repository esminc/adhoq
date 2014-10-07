require 'adhoq/engine'
require 'adhoq/global_variable'

module Adhoq
  autoload 'Error',    'adhoq/error'
  autoload 'Executor', 'adhoq/executor'
  autoload 'Report',   'adhoq/report'
  autoload 'Result',   'adhoq/result'
  autoload 'Storage',  'adhoq/storage'

  extend Adhoq::GlobalVariable
end
