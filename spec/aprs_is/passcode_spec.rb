RSpec.describe AprsIs::Passcode do
  CALLSIGN_PAIRS = [
    ['AA1AAA', 17059],
    ['A1A-9', 29651],
    ['FAKE', 32486],
    ['k1kk', 29592]
  ]

  let(:call_sign) { 'AA1AAA' }
  let(:subject) { AprsIs::Passcode.new(call_sign) }
  describe "#initialize" do
    it "requires a call_sign" do
      expect{ AprsIs::Passcode.new }.to raise_error(ArgumentError)
    end

    it "sets call_sign" do
      expect(subject.call_sign).to eq(call_sign)
    end
  end

  describe ".generate" do
    CALLSIGN_PAIRS.each do |call, passcode|
      it "return correct passcode for #{call}" do
        ps = AprsIs::Passcode.new(call)
        expect(ps.generate).to eq(passcode)
      end
    end
  end
end