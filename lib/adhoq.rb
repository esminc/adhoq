require 'adhoq/engine'
require 'adhoq/global_variable'

module Adhoq
  autoload 'Error',    'adhoq/error'
  autoload 'Executor', 'adhoq/executor'
  autoload 'Reporter', 'adhoq/reporter'
  autoload 'Result',   'adhoq/result'
  autoload 'Storage',  'adhoq/storage'

  extend Adhoq::GlobalVariable
end
