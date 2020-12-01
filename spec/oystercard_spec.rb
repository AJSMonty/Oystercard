require 'oystercard'

describe Oystercard do

  it { expect(subject).to be_kind_of(Oystercard) }

  it { expect(subject.balance).to eq(0) }

  describe '#top_up' do
    it 'adds 20 to balance' do
      expect { subject.top_up(20) }.to change { subject.balance }.from(0).to 20
    end
  
    it "throws error if try to top up balance over limit" do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      expect{ subject.top_up(10) }.to raise_error(RuntimeError, "Balance limit of #{Oystercard::BALANCE_LIMIT} exceeded")
    end
  end
  
#  describe '#decuct' do
#    it 'takes 20 of the balance' do
#        subject.top_up(50)
#        expect { subject.deduct(20) }.to change { subject.balance }.from(50).to 30
#    end
#  end

  describe "#journey" do
    let(:entry_station) { double :entry_station }
    let(:exit_station) { double :exit_station }
    it "touch_in turns in_journey? to true" do
      subject.top_up(10)
      expect{ subject.touch_in(entry_station) }.to change { subject.in_journey? }.from(false).to true
    end

    it "touch_out turns in_journey? to false" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change { subject.in_journey? }.from(true).to false
    end

    it "should check if the card is in use" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end

    it "should check if the card is in use" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq false
    end

    it 'does not let you touch_in if balance < £1' do
      expect { subject.touch_in(entry_station) }.to raise_error('Insufficient funds')
    end

    it 'deducts minimum fare on touch_out' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
    end

    it "records entry station on touch_in" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

    it 'initializes previous_journeys with empty array' do
      expect(subject.previous_journeys).to be_empty
    end

    it 'stores a journey after touch_out' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.previous_journeys).to eq [{:entry_station => entry_station, :exit_station => exit_station}]
    end

  end
end