# frozen_string_literal: true
require 'date'

RSpec.describe Bloodbath::Event do
  before do
    Bloodbath.api_key = 'TONnZlNFWYG6CZ36v4tAwfA4UKRVX3_Ou8LNRmbkSFspd4xBl3oVaKkr_UfsAL2bgg_k39ENVzY1F90urvsBVA=='
  end

  describe '#schedule' do
    subject do
      described_class.schedule(
        scheduled_for: Time.now + 60 * 60,
        method: :post,
        headers: { 'Random-Header': 'Something' },
        body: 'Random body',
        endpoint: 'https://api.fake-site.com'
      )
    end

    it { expect(subject[:data][:id]).not_to be_nil }
  end
end
