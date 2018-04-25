require 'station'

describe Station do

  subject(:station) {described_class.new(name: "Liverpool Street",zone: 1)}

  describe "#initialize" do
    it "has a name" do
      expect(station.name).to eq "Liverpool Street"
    end
  end
end
