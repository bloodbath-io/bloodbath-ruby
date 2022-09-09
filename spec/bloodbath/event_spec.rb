# frozen_string_literal: true

RSpec.describe(Bloodbath::Event, vcr: true) do
  let(:valid_api_key) { "0u9dmuz_uxQf4bD_rYzltCWA8hrUjvxQQ-ILWFppj7sfSfkjoNqbCX_oqtJ1ska3GaYACb25Ef-uYcbITTYJbA==" }

  before do
    Bloodbath.api_base = "http://localhost:4000/rest"
    Bloodbath.api_key = valid_api_key
  end

  describe ".schedule" do
    subject { described_class.schedule(params) }

    let(:scheduled_for) { Time.now + 60 * 60 }
    let(:method) { :post }
    let(:headers) { { "Random-Header": "Something" } }
    let(:body) { "Random body" }
    let(:endpoint) { "https://api.fake-site.com" }
    let(:params) do
      {
        scheduled_for: scheduled_for,
        method: method,
        headers: headers,
        body: body,
        endpoint: endpoint,
      }
    end

    it { expect(subject[:data][:id]).not_to(be_nil) }

    describe "#schedule" do
      subject { described_class.new.schedule(params) }

      it { expect(subject[:data][:id]).not_to(be_nil) }
    end
  end

  describe ".list" do
    subject do
      described_class.list
    end

    describe "#list" do
      subject { described_class.new.list }

      it { expect(subject[:data]).to(be_an_instance_of(Array)) }
    end
  end

  describe ".find" do
    subject do
      described_class.find(id)
    end

    let(:id) { "03672ed3-532f-41b7-986f-35d380b1ce6b" }

    it { expect(subject[:data][:id]).not_to(be_nil) }

    describe "#find" do
      subject { described_class.new.find(id) }

      let(:id) { "058a48a2-121d-46f4-ac54-2d8e7a44817b" }

      it { expect(subject[:data][:id]).not_to(be_nil) }
    end
  end

  describe ".cancel" do
    subject do
      described_class.cancel(id)
    end

    let(:id) { "03672ed3-532f-41b7-986f-35d380b1ce6b" }

    it { expect(subject[:data]).to(be_nil) }

    describe "#cancel" do
      subject { described_class.new.cancel(id) }

      let(:id) { "058a48a2-121d-46f4-ac54-2d8e7a44817b" }

      it { expect(subject[:data]).to(be_nil) }
    end
  end
end
