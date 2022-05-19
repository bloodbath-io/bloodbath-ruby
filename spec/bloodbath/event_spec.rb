# frozen_string_literal: true

RSpec.describe(Bloodbath::Event, vcr: true) do
  let(:valid_api_key) { "0u9dmuz_uxQf4bD_rYzltCWA8hrUjvxQQ-ILWFppj7sfSfkjoNqbCX_oqtJ1ska3GaYACb25Ef-uYcbITTYJbA==" }
  before do
    Bloodbath.api_base = "http://localhost:4000/rest"
    Bloodbath.api_key = valid_api_key
  end

  describe ".schedule" do
    let(:scheduled_for) { Time.now + 60 * 60 }
    let(:method) { :post }
    let(:headers) { {"Random-Header": "Something"} }
    let(:body) { "Random body" }
    let(:endpoint) { "https://api.fake-site.com" }
    let(:params) do
      {
        scheduled_for: scheduled_for,
        method: method,
        headers: headers,
        body: body,
        endpoint: endpoint
      }
    end

    subject { described_class.schedule(params) }

    it { expect(subject[:data][:id]).not_to(be_nil) }

    context "#schedule" do
      subject { described_class.new.schedule(params) }
      it { expect(subject[:data][:id]).not_to(be_nil) }
    end
  end

  describe ".list" do
    subject do
      described_class.list
    end

    context "#list" do
      subject { described_class.new.list }
      it { expect(subject[:data]).to(be_an_instance_of(Array)) }
    end
  end

  describe ".find" do
    let(:id) { "03672ed3-532f-41b7-986f-35d380b1ce6b" }

    subject do
      described_class.find(id)
    end

    it { expect(subject[:data][:id]).not_to(be_nil) }

    context "#find" do
      let(:id) { "058a48a2-121d-46f4-ac54-2d8e7a44817b" }

      subject { described_class.new.find(id) }
      it { expect(subject[:data][:id]).not_to(be_nil) }
    end
  end

  describe ".cancel" do
    let(:id) { "03672ed3-532f-41b7-986f-35d380b1ce6b" }

    subject do
      described_class.cancel(id)
    end

    it { expect(subject[:data]).to(eq(nil)) }

    context "#cancel" do
      let(:id) { "058a48a2-121d-46f4-ac54-2d8e7a44817b" }

      subject { described_class.new.cancel(id) }
      it { expect(subject[:data]).to(eq(nil)) }
    end
  end
end
