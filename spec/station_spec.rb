require 'station'

describe Station do

  subject(:station) {described_class.new(name: "Liverpool Street",zone: 1)}

  describe '#initialize' do
    it 'has a name' do
      expect(station.instance_variable_defined?(:@name)).to be true
    end
    it 'has a zone' do
      expect(station.instance_variable_defined?(:@zone)).to be true
    end
  end


  describe "attribute reader methods" do
    it 'has a #name' do
      expect(station.name).to eq "Liverpool Street"
    end
    it 'has a #zone' do
      expect(station.zone). to eq 1
    end
  end
end
