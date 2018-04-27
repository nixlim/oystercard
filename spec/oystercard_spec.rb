require 'oystercard'

describe Oystercard do
  let(:journey_class) { double :journey_double, new: journey }
  let(:journey) { spy :journey, start_journey: nil}
  let(:oystercard) { Oystercard.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station}


  describe '#balance' do
    it 'should return the balance' do
      expect(oystercard.balance).to eq DEFAULT_BALANCE
    end
  end

  describe '#initialise' do
    it 'should have #list_of_journeys as an empty hash' do
      expect(subject.list_of_journeys).to be_empty
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
        subject.touch_in(entry_station)
      }.to raise_error 'Insufficient funds for a journey'
    end
    context 'changes caused by touch_in' do
      before(:each) do
        subject.instance_variable_set(:@balance, 20)
      end
    end
  end

  describe '#touch_out' do
    it 'should deduct minimum fare upon #touch_out'
  end
end
