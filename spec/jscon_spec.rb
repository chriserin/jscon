require 'jscon'
require 'ostruct'

describe Jscon do
  it 'should process js' do
    repl = Jscon::Repl.new(options = OpenStruct.new(coffee?: false))
    def repl.repl_write(value); value; end;
    repl.setup
    sleep 1;
    output = repl.process_input "1 + 2"
    repl.teardown

    expect(output).to eq '3'
  end
end
