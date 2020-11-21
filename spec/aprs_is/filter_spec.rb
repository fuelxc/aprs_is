RSpec.describe AprsIs::Filter do
  let(:filter_type) { :range }
  let(:filter_values) { [1.11111, -11.11111, 15] }
  let(:subject) { AprsIs::Filter.new(type: filter_type, values: filter_values ) }

  describe "#initialize" do
    it "requires a valid type" do
      expect{ AprsIs::Filter.new(type: :asdf, values: [1]) }.to raise_error(AprsIs::Filter::InvalidTypeError)
    end

    it "requires a right number of values" do
      expect{ AprsIs::Filter.new(type: :type, values: [1,2]) }.to raise_error(AprsIs::Filter::ValueArityError)
    end

    it "sets filter_type" do
      expect(subject.filter_type).to eq(filter_type)
    end

    it "sets values" do
      expect(subject.values).to eq(filter_values)
    end
  end

  describe ".to_s" do
    it "is in format <prefix>/<value_1>/..." do
      expect(subject.to_s).to eq("r/1.11111/-11.11111/15")
    end
  end
end