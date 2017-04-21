require 'journey'

describe Journey do

  let (:station){double(:station)}
  
  it { is_expected.to respond_to(:entry_station) }

  before (:each) do
    allow(station).to receive(:name) {station}
    subject.entry_station = station
  end


  it 'expects history to be an empty array' do
    expect(subject.history).to eq([])
  end

  it 'stores entry and exit stations in a hash' do
    subject.exit_st(station)
    expect(subject.history).to eq ([{station => station}])
  end

  describe '#enter' do
    it 'makes in journey status true' do
      expect(subject.in_journey?).to eq true
    end
  end

  it 'remembers that we entered Aldgate station' do
    expect(subject.entry_station).to eq station
  end

  describe '#exit_st' do
    it 'makes in journey status false' do
      allow(station).to receive(:name) {station}
      subject.exit_st(station)
      expect(subject.in_journey?).to eq false
    end
  end

  it 'sets entry station to nil' do
    subject.exit_st(station)
    expect(subject.entry_station).to eq nil
  end

end
