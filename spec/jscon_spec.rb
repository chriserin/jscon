require 'jscon'
require 'ostruct'

describe Jscon do
  before do
    def repl.repl_write(value); value; end;
    repl.setup
    sleep 0.6
  end

  let(:repl) {Jscon::Repl.new(options = OpenStruct.new(coffee?: coffee))}

  context 'without coffee' do
    let(:coffee) { false }

    it 'should process js' do
      output = repl.process_input "1 + 2"
      expect(output).to eq '3'
    end
  end

  context 'with coffee' do
    let(:coffee) { true }

    it 'should process coffee' do
      repl.process_input "@a = 1 + 2"
      repl.process_input "@b= -> @a"
      output = repl.process_input "@b()"
      expect(output).to eq '3'
    end
  end

  after do
    repl.teardown
  end
end
