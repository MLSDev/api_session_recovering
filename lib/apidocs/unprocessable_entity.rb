# frozen_string_literal: true

class ApiSessionRecovering::UnprocessableEntity
  include Swagger::Blocks

  swagger_schema :UnprocessableEntity do
    property :errors do
      key :'$ref', :Errors
    end
  end

  swagger_schema :Errors do
    property :error_field do
      key :type, :array
      items do
        key :type, :string
      end
    end
  end
end
