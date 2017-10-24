require 'rails_helper'

describe ApiSessionRecovering::ApplicationRecord do
  it { expect(described_class.superclass).to eq ActiveRecord::Base }

  it { expect(described_class.abstract_class).to be_truthy }
end
