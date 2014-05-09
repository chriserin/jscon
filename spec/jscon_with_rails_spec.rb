require 'jscon'
require 'ostruct'

describe Jscon do
  before do
    Jscon::Session.stub(rails_app_path: 'spec/fixtures/dummy/config/environment.rb')
    def repl.repl_write(value); value; end;
    repl.setup
    sleep 0.6
  end

  let(:repl) {Jscon::Repl.new(options = OpenStruct.new(coffee?: coffee))}

  context 'with asset server' do
    let(:coffee) { true }

    it 'should find jquery' do
      output = repl.process_input "$"
      expect(output).to match /Function/
    end
  end

  after do
    repl.teardown
  end
end
