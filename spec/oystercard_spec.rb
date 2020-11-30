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
end