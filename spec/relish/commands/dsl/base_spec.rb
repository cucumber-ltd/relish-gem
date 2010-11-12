require 'spec_helper'

module Relish
  module Command
    module Dsl
      describe Base do
        
        describe '#context_eval' do
          let(:context_class) { Class.new }
          let(:base) { described_class.new(context_class) }
          let(:the_block) { Proc.new { "Hi, I'm a block" } }
          
          it 'calls class_eval on the context_class with the given block' do
            context_class.should_receive(:class_eval).with(&the_block)
            base.context_eval(&the_block)
          end
        end
        
        describe '#context_name' do
          let(:context_class) { Class.new }
          let(:base) { described_class.new(context_class) }
          before { context_class.should_receive(:name).and_return('::Dog') }
          
          it 'returns the class name downcased' do
            base.context_name.should eq('dog')
          end
        end
        
      end
    end
  end
end