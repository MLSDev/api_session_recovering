require 'api_session_recovering/configuration'
require 'api_session_recovering/engine'
require 'validators'
require 'email_validator'

module ApiSessionRecovering
  autoload :EmailValidator, 'email_validator'

  def self.configure(&block)
    block.call configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
