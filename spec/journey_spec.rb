require 'journey'

describe Journey do
  let(:card) { instance_double Oystercard, balance: 2 }
  let(:entry_station) { instance_double Station, name: "Liverpool Street", zone: 1 }
  let(:exit_station) { instance_double Station, name: "Paddington Station", zone: 2 }
  let(:journey) {described_class.new(entry_station, card.balance)}


  describe '#initialize' do
    it 'stores an entry_station' do
      expect(journey.instance_variable_get(:@entry_station)).to eq(entry_station)
    end

    it 'stores a balance' do
      expect(journey.instance_variable_get(:@balance)).to eq(2)
    end
  end

  describe '#finish journey' do
    it 'stores an exit station' do
      journey.finish_journey(exit_station, card.balance)
      expect(journey.instance_variable_get(:@exit_station)).to eq(exit_station)
    end
  end
end
