require 'spec_helper'

module Relish
  module Command
    describe Push do
      
      describe '#default' do
        let(:push) { described_class.new }
        
        it 'calls #post' do
          push.should_receive(:post)
          push.default
        end
      end
      
    end
  end
end