require 'spec_helper'

module Relish
  module Command
    describe Config do
      
      
      describe '#default' do
        let(:config) { described_class.new }
        
        context 'with a local options file' do
          before do
            File.should_receive(:exists?).and_return(true)
            IO.should_receive(:read).and_return('options')
          end
          
          it 'outputs the contents' do
            config.should_receive(:puts).with('options')
            config.default
          end
        end
        
        context 'without a local options file' do
          it 'outputs the correct message' do
            config.should_receive(:puts).with('No .relish file exists')
            config.default
          end
        end
      end
      
    end
  end
end