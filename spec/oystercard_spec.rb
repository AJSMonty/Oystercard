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
  
  describe '#decuct' do
    it 'takes 20 of the balance' do
        subject.top_up(50)
        expect { subject.deduct(20) }.to change { subject.balance }.from(50).to 30
    end
  end

  describe "#journey" do
    
    it "touch_in turns in_journey? to true" do
      subject.top_up(10)
      expect{ subject.touch_in }.to change { subject.in_journey? }.from(false).to true
    end

    it "touch_out turns in_journey? to false" do
      subject.top_up(10)
      subject.touch_in
      expect{ subject.touch_out }.to change { subject.in_journey? }.from(true).to false
    end

    it "should check if the card is in use" do
      subject.top_up(10)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end

    it "should check if the card is in use" do
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end

    it 'does not let you touch_in if balance < £1' do
      expect { subject.touch_in }.to raise_error('Insufficient funds')
    end
  end
end