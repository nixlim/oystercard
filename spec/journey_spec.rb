require 'journey'

describe Journey do
  let(:card) { instance_double Oystercard, balance: 2 }
  let(:entry_station) { instance_double Station, name: "Liverpool Street", zone: 1 }
  let(:exit_station) { instance_double Station, name: "Paddington Station", zone: 2 }



  describe '#start_journey' do
    it { is_expected.to respond_to(:start_journey).with(2).arguments }

    it 'stores an entry_station' do
      subject.start_journey(entry_station, card.balance)
      expect(subject.instance_variable_get(:@entry_station)).to eq(entry_station)
    end

    it 'stores a balance' do
      subject.start_journey(entry_station, card.balance)
      expect(subject.instance_variable_get(:@balance)).to eq(2)
    end

  end
end
