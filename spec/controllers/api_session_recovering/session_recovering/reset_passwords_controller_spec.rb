require 'rails_helper'

describe ApiSessionRecovering::SessionRecovering::ResetPasswordsController do
  it { should be_a ApiSessionRecovering::BaseController }

  describe '#build_resource' do
    before { expect(controller).to receive(:resource_params).and_return :resource_params }

    before { expect(ApiSessionRecovering::ResetPasswordService).to receive(:new).with(controller.request, :resource_params) }

    it { expect { controller.send :build_resource }.not_to raise_error }
  end

  describe '#resource' do
    before { controller.instance_variable_set(:@resource, :resource) }

    its(:resource) { should eq :resource }
  end
end
