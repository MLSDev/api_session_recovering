class ApiSessionRecovering::RestorePasswordDocs
  require 'apidocs/unprocessable_entity'
  include Swagger::Blocks

  swagger_path '/session_recovering/restore_password' do
    operation :post do
      key :description, 'restore_password'
      key :summary, '1st step of password recovering. Generates the code and sends it to user.'
      key :tags, ['Restore password']
      key :consumes, ['multipart/form-data']
      security do
        key :api_key, []
      end
      parameter do
        key :name, 'restore_password[email]'
        key :in, :formData
        key :required, true
        key :type, :string
      end
      parameter do
        key :name, 'restore_password[frontend_path]'
        key :in, :formData
        key :required, false
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

  swagger_path '/session_recovering/restore_passwords/{token}' do
    operation :get do
      key :description, 'Validate restore token'
      key :summary, 'validate restore token'
      key :tags, ['Restore password']
      key :consumes, ['multipart/form-data']
      security do
        key :api_key, []
      end
      parameter do
        key :name, :token
        key :in, :frontend_path
        key :required, true
        key :type, :string
      end

      response '204' do
        key :description, 'Success without body'
      end

      response '404' do
        key :description, 'NotFound'
      end
    end
  end
end
