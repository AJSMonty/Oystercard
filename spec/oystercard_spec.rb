require 'oystercard'

describe Oystercard do

  it { expect(subject).to be_kind_of(Oystercard) }

  it { expect(subject.balance).to eq(0) }

  it 'adds a tenner to balance' do
    expect { subject.top_up(20) }.to change { subject.balance }.from(0).to 20
  end
  
end