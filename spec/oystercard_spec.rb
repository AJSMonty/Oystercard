require 'oystercard'

describe Oystercard do

  it { expect(subject).to be_kind_of(Oystercard) }

  it { expect(subject.balance).to eq(0) }
  
end