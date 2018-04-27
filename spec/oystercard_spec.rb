require 'oystercard'

describe Oystercard do
  #
  # let(:journey_class) { double :journey_double, new: journey }
  let(:journey) { spy :journey }
  let(:oystercard) { Oystercard.new(journey) }

  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station}


  describe '#balance' do
    it 'should return the balance' do
      expect(oystercard.balance).to eq DEFAULT_BALANCE
    end
  end

  describe '#initialise' do
    it 'should have #list_of_journeys as an empty hash' do
      expect(oystercard.list_of_journeys).to be_empty
    end
  end


  describe '#top_up' do
    it 'should return correct balance when topped up' do
      expect { oystercard.top_up(10) }.to change { oystercard.balance }.by(10)
    end

  it 'should raise error if total exceeds max limit' do
    expect { oystercard.top_up(100) }.to raise_error("Cannot top up as balance exceeds maximum limit.")
  end
end

  describe '#touch_in' do

    it 'should raise an error message if balance on #touch_in is less than £1' do
      expect {
        oystercard.touch_in(entry_station)
      }.to raise_error 'Insufficient funds for a journey'
    end
    it 'should send .start_jouney to journey' do
      oystercard.top_up(5)
      oystercard.touch_in(entry_station)
      expect(journey).to have_received(:start_journey)
    end
    it 'should record the entry station in @list_of_stations' do
      oystercard.top_up(5)
      oystercard.touch_in(entry_station)
      expect(oystercard.list_of_journeys.last[:entry_station]).to eq entry_station
    end

  end

  describe '#touch_out' do
    it 'should have a #touch_out method' do
      expect(oystercard).to respond_to(:touch_out)
    end
    it 'should send .end_journey to journey' do
      oystercard.top_up(5)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(journey).to have_received(:end_journey)
    end
    it 'should record the exit station in the @list_of_stations' do
      oystercard.top_up(5)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.list_of_journeys.last[:exit_station]).to eq exit_station
    end
    # it 'should reduce the balance by MINIMUM_FARE' do
    #   expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by(-1)
    # end
    # it 'should deduct minimum fare upon #touch_out'
  end
end
