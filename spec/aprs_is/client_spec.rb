RSpec.describe AprsIs::Client do
  let(:host) { 'local.test' }
  let(:port) { '12345' }
  let(:subject) { AprsIs::Client.new(hostname: host, port: port) }

  let(:socket) { double }

  before(:each) do
    allow(TCPSocket).to receive(:open).with(host, port).and_return(socket)
  end

  describe '#initialize' do
    it "requires hostname" do
      expect{ AprsIs::Client.new(port: port) }.to raise_error(ArgumentError)
    end

    it "requires port" do
      expect{ AprsIs::Client.new(hostname: host) }.to raise_error(ArgumentError)
    end

    it "sets hostname" do
      expect(subject.hostname).to eq(host)
    end

    it "sets port" do
      expect(subject.port).to eq(port)
    end

    it "sets default version" do
      expect(subject.version).to eq("AprsIs::Client v0.1.2")
    end

    it "accepts version" do
      expect{ AprsIs::Client.new(hostname: host, port: port, version: "Dummy 1.2.3") }.to_not raise_error
    end

    it "sets version" do
      versioned = AprsIs::Client.new(hostname: host, port: port, version: "Dummy 1.2.3")
      expect(versioned.version).to eq("Dummy 1.2.3")
    end
  end

  describe '.login' do
    it "requires a call_sign" do
      expect{ subject.login }.to raise_error(ArgumentError)
    end

    it "sends login to the socket" do
      expect(subject).to receive(:send_message).with("user AA1AAA pass 17059 vers AprsIs::Client v0.1.2")
      subject.login('AA1AAA')
    end

    it "accepts a filter" do
      expect(subject).to receive(:send_message).with("user AA1AAA pass 17059 vers AprsIs::Client v0.1.2 filter r/1.11111/-11.11111/15")
      filter = double
      allow(filter).to receive(:to_s).and_return("r/1.11111/-11.11111/15")
      subject.login('AA1AAA', [filter])
    end
  end

  describe '.send_message' do
    it "requires a message" do
      expect{ subject.send_message }.to raise_error(ArgumentError)
    end

    it 'sends the message to the socket' do
      expect(socket).to receive(:puts).with('Foo Bar')
      subject.send_message('Foo Bar')
    end
  end

  describe '.apply_filter' do
    it "requires a filter" do
      expect{ subject.apply_filter }.to raise_error(ArgumentError)
    end

    it 'sends the message to the socket' do
      expect(socket).to receive(:puts).with('filter r/1.11111/-11.11111/15')
      filter = double
      allow(filter).to receive(:to_s).and_return("r/1.11111/-11.11111/15")
      subject.apply_filter(filter)
    end
  end

  describe '.read' do
    it "requires a block" do
      allow(socket).to receive(:gets).and_return('aprs message')
      expect{ subject.read }.to raise_error(LocalJumpError)
    end

    it "yields lines to the block" do
      allow(socket).to receive(:gets).and_return('aprs message', nil)
      expect{ |probe| subject.read(&probe) }.to yield_with_args('aprs message')
    end
  end
end
