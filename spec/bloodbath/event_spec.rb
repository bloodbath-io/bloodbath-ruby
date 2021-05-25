# frozen_string_literal: true
RSpec.describe Bloodbath::Event do
  describe '#schedule' do
    subject { described_class.schedule() }
    it { expect { subject }.to change { true }.to (false) }
  end
end
