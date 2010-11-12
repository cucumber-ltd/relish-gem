require 'spec_helper'

module Relish
  module Command
    module Dsl
      describe Command do
        
        it_should_behave_like 'a Dsl that utilizes ContextClass'
        
        describe '#define' do
          let(:context_class) { Class.new }
          let(:command) { described_class.new(context_class) }
          let(:the_instance) { context_class.new }
          
          before do
            context_class.should_receive(:name).and_return('::Dog')
            HelpText.stub(:add)
          end
          
          it 'defines an instance method on the context class' do
            command.define(:my_command) {}
            the_instance.should respond_to(:my_command)
          end
          
          context 'the instance method' do
            
            it 'evaluates the block' do
              command.define(:my_command) { 'my command value' }
              the_instance.my_command.should eq('my command value')
            end
            
            it 'rescues RestClient::Exception' do
              command.define(:my_command) do
                raise RestClient::Exception.new('uh oh an exception')
              end
              the_instance.should_receive(:warn).with('uh oh an exception')
              the_instance.should_receive(:exit).with(1)
              the_instance.my_command
            end
              
          end
          
        end
        
      end
    end
  end
end