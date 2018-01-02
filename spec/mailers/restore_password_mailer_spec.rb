require 'rails_helper'

describe RestorePasswordMailer do
  let(:user_class) { 'Admin' }

  subject { RestorePasswordMailer.email 'petewong88@gmail.com', 'Uyte6hoI6F', 'http://example.com' }

  its(:subject) { should eq 'Restore password' }
end
