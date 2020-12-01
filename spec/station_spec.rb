require 'station'

describe Station do

    let(:name) { double :name }
    let(:zone) { double :zone }
    it { expect(Station).to respond_to(:new).with(2).arguments }

    it 'returns name and zone' do
        new_station = Station.new(name, zone)
        expect(new_station.name).to eq name
        expect(new_station.zone).to eq zone
    end

end