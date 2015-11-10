require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.file_cache_path = '/tmp/chef/cache'
end
