require 'rails_helper'

describe ApiSessionRecovering::BaseController do
  it { should be_a ApiSessionRecovering::ApplicationController }

  it { should respond_to? :resource }

  it { should respond_to? :collection }

  it { should respond_to? :build_resource }

  it { should rescue_from ActionController::ParameterMissing }

  it { should rescue_from ActiveRecord::RecordInvalid }

  it { should rescue_from ActiveModel::StrictValidationFailed }

  it { should rescue_from ActiveRecord::RecordNotFound }

  describe '#create' do
    let(:resource) { double }

    before { expect(controller).to receive :build_resource }

    before { expect(controller).to receive(:resource).and_return resource }

    before { expect(resource).to receive :save! }

    specify { expect { controller.create }.to_not raise_error }
  end
end
