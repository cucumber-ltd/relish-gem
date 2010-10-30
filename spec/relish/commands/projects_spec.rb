require 'spec_helper'

module Relish
  module Command
    describe Projects do
      
      describe '#default' do
        let(:projects) { described_class.new }
        
        it 'calls #list' do
          projects.should_receive(:list)
          projects.default
        end
      end 
      
    end
  end
end