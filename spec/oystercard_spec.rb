require 'oystercard'

describe Oystercard do

  let (:station){double(:station)}

  it { is_expected.to respond_to(:balance) }

  it 'initializes with a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do
    it 'tops up balance by specified amount' do
      subject.top_up(15)
      expect(subject.balance).to eq 15
    end

    it 'raises an error if top-up would push balance above £90' do
      expect{ subject.top_up(100) }.to raise_error "Top-up would exceed £#{Oystercard::DEFAULT_LIMIT} limit"
    end
  end

  describe '#deduct' do
    it "reduces balance by given amount" do
      subject.top_up(50)
      expect(subject.send(:deduct,40)).to eq 10
    end
  end

  it "raises and error if balance is less than minimum charge" do
    expect {subject.touch_in('Aldgate','1')}.to raise_error "Insufficient funds!"
  end

  it 'deducts fare upon touching out' do
    expect {subject.touch_out('Liverpool St', '3')}.to change{subject.balance}.by(-Oystercard::MINIMUM_BALANCE)
  end

  it 'raises an error if the customer doesn\'t touch out'  do
    subject.top_up(50)
    subject.touch_in('aldgate','3')
    expect {subject.touch_in('Fulham',3)}.to raise_error "Did not touch out, fare penalty of £#{Oystercard::PENALTY}"
  end


  it 'charges a penalty of 6 if customer doesnt #touch_out' do
    subject.top_up(21)
    subject.touch_in('aldgate','3')
    subject.touch_in('Fulham','3')
    expect (subject.balance).to eq 15
  end

end
