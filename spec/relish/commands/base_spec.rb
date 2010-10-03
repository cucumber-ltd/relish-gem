require 'spec_helper'

module Relish
  module Command
    describe Base do
      
      describe '#api_token' do
        let(:base) { described_class.new }
        
        it 'calls File.read with the correct path' do
          base.should_receive(:home_directory).and_return('~')
          File.should_receive(:read).with('~/.relish/api_token')
          base.api_token
        end
      end
      
    end
  end
end