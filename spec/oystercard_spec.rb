require 'oystercard'

describe Oystercard do

  it { expect(subject).to be_kind_of(Oystercard) }

  it { expect(subject.balance).to eq(0) }

  it 'adds a tenner to balance' do
    expect { subject.top_up(20) }.to change { subject.balance }.from(0).to 20
  end
  
  describe "#limit" do
    it "throws error if try to top up balance over limit" do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      expect{ subject.top_up(10) }.to raise_error(RuntimeError, "Balance limit of #{Oystercard::BALANCE_LIMIT} exceeded")
    end
  end
end