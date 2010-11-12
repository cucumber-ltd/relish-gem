require 'spec_helper'

module Relish
  module Command
    module Dsl
      describe Option do
        
        describe '#define' do
          let(:context_class) { Class.new }
          let(:option) { described_class.new(context_class) }
          let(:the_instance) { context_class.new }
          
          before do
            option.define(:my_option, :default => lambda { "I'm a proc!" })
          end
          
          it 'defines an instance method on the context class' do
            the_instance.should respond_to(:my_option)
          end
          
          context 'the instance method' do
            
            it 'calls on #cli_options' do
              the_instance.should_receive(:cli_options).and_return(
                'my_option' => 'a_cli_option_value'
              )
              the_instance.my_option.should eq('a_cli_option_value')
            end
            
            it 'calls on #local_options_file' do
              the_instance.should_receive(:cli_options).and_return({})
              the_instance.should_receive(:local_options_file).and_return(
                'my_option' => 'a_local_option_value'
              )
              the_instance.my_option.should eq('a_local_option_value')
            end
            
            it 'calls on #global_options_file' do
              the_instance.should_receive(:cli_options).and_return({})
              the_instance.should_receive(:local_options_file).and_return({})
              the_instance.should_receive(:global_options_file).and_return(
                'my_option' => 'a_global_option_value'
              )
              the_instance.my_option.should eq('a_global_option_value')
            end
            
            it 'calls the :default proc' do
              the_instance.should_receive(:cli_options).and_return({})
              the_instance.should_receive(:local_options_file).and_return({})
              the_instance.should_receive(:global_options_file).and_return({})
              the_instance.my_option.should eq("I'm a proc!")
            end
              
          end
          
        end
        
        describe '.names' do
          specify { described_class.should_not have(0).names }
        end
        
      end
    end
  end
end