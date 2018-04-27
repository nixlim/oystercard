require 'oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station}
  let(:journey_class) { double :journey_double, new: journey }
  let(:journey) { spy :journey}

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
    it 'should check whether the last journey is complete' do
      subject.instance_variable_set(:@balance, 20)
      subject.instance_variable_set(:@journey_class, journey_class)
      subject.touch_in(entry_station)
      expect(journey).to have_received(:fare)
    end
    it 'should raise an error message if balance on #touch_in is less than £1' do
      subject.instance_variable_set(:@journey_class, journey_class)
      expect {
        subject.touch_in(entry_station)
      }.to raise_error 'Insufficient funds for a journey'
    end
    context 'changes caused by touch_in' do
      before(:each) do
        subject.instance_variable_set(:@balance, 20)
      end
      it 'should send #complete? to journey on touch_in' do
        subject.instance_variable_set(:@journey_class, journey_class)
        allow(journey).to receive(:complete?).and_return(false)
        subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end
      it 'should remember the entry station' do
        subject.instance_variable_set(:@journey_class, journey_class)
        subject.touch_in(entry_station)
        variable = subject.instance_variable_get(:@journey)[:entry_station]
        expect(variable).to eq entry_station
      end
    end
  end

  describe '#touch_out' do
    it 'should deduct minimum fare upon #touch_out' do
      subject.instance_variable_set(:@balance, 20)
      subject.instance_variable_set(:@journey_class, journey_class)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change {
        subject.balance
      }.by(-1)
    end
    context 'touch out affects in_journey? method' do
      before(:each) do
        subject.instance_variable_set(:@balance, 20)
        subject.instance_variable_set(:@journey_class, journey_class)
        subject.touch_in(entry_station)
      end
      it 'should store exit_station on touch_out' do
        subject.touch_out(exit_station)
        expect(subject.list_of_journeys.last[:exit_station]).to eq exit_station
      end
      it 'should change in_journey? on touch_out' do
        subject.touch_out(exit_station)
        expect(subject).not_to be_in_journey
      end
    end
  end

  context 'touching in and out' do
    before(:each) do
      subject.instance_variable_set(:@balance, 20)
      subject.instance_variable_set(:@journey_class, journey_class)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end

    it 'should store one journey' do
      expect(subject.list_of_journeys.length).to eq 1
    end
  end
end
