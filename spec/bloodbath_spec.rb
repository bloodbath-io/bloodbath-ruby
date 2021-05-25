# frozen_string_literal: true
RSpec.describe Bloodbath do
  it { expect(Bloodbath::VERSION).not_to be nil }

  describe '#api_key' do
    subject { described_class.api_key }
    let(:api_key) { 'valid-api-key'}
    it { expect { described_class.api_key = api_key }.to change { described_class.api_key }.to (api_key) }
  end
end
