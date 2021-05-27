# frozen_string_literal: true
require 'date'

RSpec.describe Bloodbath::Event, vcr: true do
  before do
    Bloodbath.api_key = 'TONnZlNFWYG6CZ36v4tAwfA4UKRVX3_Ou8LNRmbkSFspd4xBl3oVaKkr_UfsAL2bgg_k39ENVzY1F90urvsBVA=='
  end

  describe '#schedule' do
    let(:scheduled_for) { Time.now + 60 * 60 }
    let(:method) { :post }
    let(:headers) { { 'Random-Header': 'Something' } }
    let(:body) { 'Random body' }
    let(:endpoint) { 'https://api.fake-site.com' }

    subject do
      described_class.schedule(
        scheduled_for: scheduled_for,
        method: method,
        headers: headers,
        body: body,
        endpoint: endpoint
      )
    end

    it { expect(subject[:data][:id]).not_to be_nil }
  end

  describe '#list' do
    subject do
      described_class.list
    end

    it { expect(subject[:data]).to be_an_instance_of(Array) }
  end

  describe '#find' do
    let(:id) { 'da7fe5c3-0df0-48c9-b8cd-a1e3a6ef2d48' }

    subject do
      described_class.find(id)
    end

    it { expect(subject[:data][:id]).not_to be_nil }
  end

  describe '#cancel' do
    let(:id) { '5a9b0427-0b3c-4de4-a797-70b734540a78' }

    subject do
      described_class.cancel(id)
    end

    it { expect(subject).to eq({}) }
  end

end
