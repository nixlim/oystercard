require 'journey'

describe Journey do
  let(:entry_station) { instance_double Station, name: "Liverpool Street", zone: 1 }
  let(:exit_station) { instance_double Station, name: "Paddington Station", zone: 2 }
  let(:journey) {described_class.new}

  describe '#start_journey' do
    it 'should record the entry station' do
      journey.start_journey(entry_station)
      expect(journey.entry_station).to eq entry_station
    end
  end

  describe '#end_journey' do
    it 'should record the exit station' do
      journey.end_journey(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end

  describe '#complete?' do
    it 'should return true if journey was started and ended' do
      journey.start_journey(entry_station)
      journey.end_journey(exit_station)
      expect(journey.complete?).to be true
    end
    it 'should return false if journey was started but not ended' do
      journey.start_journey(entry_station)
      expect(journey.complete?).to be false
    end
    it 'should return false if journey was ended but not started' do
      journey.end_journey(exit_station)
      expect(journey.complete?).to be false
    end
  end

  describe '#fare' do
    it 'should charge the penalty fare if journey not complete' do
      allow(journey).to receive(:complete?) { false }
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
    it 'should charge the minimum fare if journey complete' do
      allow(journey).to receive(:complete?) { true }
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end
  end

end
