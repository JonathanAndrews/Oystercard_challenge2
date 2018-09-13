require "journey"

describe Journey do

  context "#touch_in"do

    it "should return true" do
      expect(subject.touch_in("Hammersmith")).to eq true
    end

    it "sets card as 'in use'" do
      expect(subject.touch_in("Hammersmith")).to eq true
    end

    it "remembers station" do
      subject.touch_in("Hammersmith")
      expect(subject.entry_station).to eq "Hammersmith"
    end

  end

  context "touch_out" do

    it "should return false" do
      expect(subject.touch_out("Old Street")).to eq false
    end

    it "sets card to 'not in use'" do
      expect(subject.touch_out("Old Street")).to eq false
    end

    it "sets card to 'not in use'" do
      expect(subject.touch_out("Old Street")).to eq false
    end


  end

  context "#in_journey?" do

    it "Journey#in_journey?" do
      expect(subject.in_journey?).to eq false
    end

    it "Journey#in_journey?" do
      subject.touch_in("Hammersmith")
      expect(subject.in_journey?).to eq true
    end

  end

  context "predicate methods for Penalty charge" do

    it "expects Journey#no_touch_in?" do
      subject.touch_in("Hammersmith")
      expect(subject.no_touch_in?).to be_falsey
    end

    it "expects Journey#no_touch_out?" do
      subject.touch_in("Bethnal Green")
      expect(subject.no_touch_out?).to be_falsey
    end

  end

    # describe "Oystercard#fare" do
    #
    #   let(:journey) { double :journey }
    #   let(:subject) { described_class.new(journey) }
    #
    #   it "Oystercard#fare returns minimum fare in normal conditions" do
    #     allow(journey).to receive(:no_touch_in?).and_return(false)
    #     allow(journey).to receive(:no_touch_out?).and_return(false)
    #     expect(subject.fare).to eq(Oystercard::MIN_CHARGE)
    #   end
    #
    #   it "Oystercard#fare returns minimum penalty fare in no #touch_in conditions" do
    #     allow(journey).to receive(:no_touch_in?).and_return(true)
    #     expect(subject.fare).to eq(Oystercard::PENALTY_CHARGE)
    #   end
    #
    #   it "Oystercard#fare returns minimum penalty fare in no #touch_out conditions" do
    #     allow(journey).to receive(:no_touch_in?).and_return(false)
    #     allow(journey).to receive(:no_touch_out?).and_return(true)
    #     expect(subject.fare).to eq(Oystercard::PENALTY_CHARGE)
    #   end
    #
    # end

end
