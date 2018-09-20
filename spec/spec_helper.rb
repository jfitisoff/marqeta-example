require "active_support/all"
require "base64"
require "factory_bot"
require "faker"
require "securerandom"
require "yaml"


CREDS = YAML.load(File.read('credentials.yml'))

require_relative "support/api/marqeta_core"
require_relative "support/factories/user"
