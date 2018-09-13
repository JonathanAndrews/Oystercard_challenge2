require 'oystercard'

describe Oystercard do

  it "New Oystercard#balance returns 0" do
    expect(subject.balance).to eq 0
  end

  context "testing Oystercard#top_up" do

    it "Oystercard#top_up increases balance" do
      expect(subject.top_up(20)).to eq 20
    end

    it "Oystercard#top_up raises error if balance would exceed maximum" do
      max_balance = Oystercard::MAX_BALANCE
      min_charge = Oystercard::MIN_CHARGE
      expect { subject.top_up(max_balance + min_charge) }.to raise_error("Balance would exceed #{max_balance}")
    end
  end


  # context "testing Oystercard#deduct" do
  #
  #   it "Oystercard#deduct reduces balance" do
  #     subject.top_up(20)
  #     expect(subject.deduct(4)).to eq 16
  #   end
  # end

  describe "Oystercard#touch_in requires double tube_stop variable" do

    let(:tube_stop) { double :entry_station }
    let(:tube_stop2) { double :exit_station }
    let(:journey) { double :journey, no_touch_in?: false, no_touch_out?: false,
                    touch_out: false, touch_in: true
                  }
    let(:subject) { described_class.new(journey) }

    context "testing touch in" do

      it "Oystercard#touch_in throws error due to insufficient funds" do
        expect { subject.touch_in(tube_stop) }.to raise_error("Insufficient funds. Balance: #{subject.balance}")
      end
    end

    context "testing touch out" do

      before(:each) do
        subject.top_up(5)
        allow(journey).to receive(:touch_in)
        subject.touch_in(tube_stop)
      end

      it "Oystercard#touch_out deduct cost from balance" do
        expect {subject.touch_out(tube_stop2)}.to change {subject.balance}.by(-Oystercard::MIN_CHARGE)
      end

      it "Oystercard#touch_out remembers station" do
        allow(journey).to receive(:journey_history).and_return([{entry_station: tube_stop, exit_station: tube_stop2}])

        subject.touch_out(tube_stop2)
        expect(subject.journey_history).to eq [{entry_station: tube_stop, exit_station: tube_stop2}]
      end

    end

    it "Oystercard#journey_history returns empty array" do
      allow(journey).to receive(:journey_history).and_return([])
      expect(subject.journey_history).to eq []
    end

    describe "Oystercard#fare" do

      let(:journey) { double :journey }
      let(:subject) { described_class.new(journey) }

      it "Oystercard#fare returns minimum fare in normal conditions" do
        allow(journey).to receive(:no_touch_in?).and_return(false)
        allow(journey).to receive(:no_touch_out?).and_return(false)
        expect(subject.fare).to eq(Oystercard::MIN_CHARGE)
      end

      it "Oystercard#fare returns minimum penalty fare in no #touch_in conditions" do
        allow(journey).to receive(:no_touch_in?).and_return(true)
        expect(subject.fare).to eq(Oystercard::PENALTY_CHARGE)
      end

      it "Oystercard#fare returns minimum penalty fare in no #touch_out conditions" do
        allow(journey).to receive(:no_touch_in?).and_return(false)
        allow(journey).to receive(:no_touch_out?).and_return(true)
        expect(subject.fare).to eq(Oystercard::PENALTY_CHARGE + Oystercard::MIN_CHARGE)
      end

    end


  end

end
