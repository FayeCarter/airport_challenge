require 'airport'

describe Airport do

  subject(:airport) { Airport.new }
  let(:plane) { Plane.new }
  let(:clear_airport) { allow(airport).to receive(:stormy?).and_return false }

  context 'Airport can #land planes' do

    it 'Airport responds to #land' do
      expect(subject).to respond_to(:land)
    end

    it 'Plane lands in airport' do
      allow(airport).to receive(:stormy?).and_return false
      expect(airport.land).to be_instance_of(Plane)
    end

    it "Plane  won't land if airport is full" do
      #allow(airport).to receive(:stormy?).and_return false
      clear_airport
      airport.land
      expect { airport.land }.to raise_error 'Airport Full'
    end

  end

  context 'Airport can #take_off planes' do

    it 'Airport responds to #take_off' do
      expect(airport).to respond_to(:take_off)
    end

    it 'Airport responds to #view_planes' do
      expect(airport).to respond_to(:view_planes)
    end

    it '#view_plane confirms #take_off' do
      allow(airport).to receive(:stormy?).and_return false
      landed_plane = airport.land
      airport.take_off
      expect(airport.view_planes).to_not be([landed_plane])
    end

  end

  context 'Given a Capacity' do

    it "Plane  won't land if above capacity" do
      new_airport = Airport.new(72)
      allow(new_airport).to receive(:stormy?).and_return false
      72.times { new_airport.land }
      expect { new_airport.land }.to raise_error 'Airport Full'
    end

  end

  context 'Assess weather' do

    context '#stormy?' do

      it 'Airport responds to #stormy?' do
        expect(airport).to respond_to(:stormy?)
      end

      it 'cannt #take_off if stormy' do
        allow(airport).to receive(:stormy?).and_return true
        expect { airport.take_off }.to raise_error "Bad weather"
      end

      it 'cannt #land if stormy' do
        allow(airport).to receive(:stormy?).and_return true
        expect { airport.land }.to raise_error "Bad weather"
      end

    end

  end
end
