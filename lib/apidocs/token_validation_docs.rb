class ApiSessionRecovering::TokenValidationDocs
  require 'apidocs/unprocessable_entity'
  include Swagger::Blocks

  swagger_path '/session_recovering/token_validation' do
    operation :post do
      key :description, 'Validate restore token'
      key :summary, 'validate restore token'
      key :tags, ['restore password']
      security do
        key :api_key, []
      end
      parameter do
        key :name, :token
        key :in, :formData
        key :required, true
        key :type, :string
      end
      parameter do
        key :name, :email
        key :in, :formData
        key :required, true
        key :type, :string
      end
      response '204' do
        key :description, 'Success without body'
      end
      response '404' do
        key :description, 'NotFound'
      end
      response '422' do
        key :description, 'UnprocessableEntity'
        schema do
          key :'$ref', :UnprocessableEntity
        end
      end
    end
  end
end
