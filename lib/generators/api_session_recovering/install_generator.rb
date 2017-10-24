module ApiSessionRecovering
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc "Creates a ApiSessionRecovering initializer in your application's config/initializers dir"

      def copy_initializer
        template 'api_session_recovering.rb', 'config/initializers/api_session_recovering.rb'
      end

    end
  end
end
