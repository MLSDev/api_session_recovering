module ApiSessionRecovering
  class Engine < Rails::Engine
    isolate_namespace ApiSessionRecovering

    initializer "ApiSessionRecovering.extend_active_record" do
      #
    end
  end
end
