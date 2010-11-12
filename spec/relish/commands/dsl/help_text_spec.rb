require 'spec_helper'

module Relish
  module Command
    module Dsl
      describe HelpText do
        
        describe '.add' do
                    
          it 'adds a command to the hash of commands' do
            HelpText.clear_commands
            
            HelpText.should_receive(:get_next_usage).and_return('usage')
            HelpText.should_receive(:get_next_description).and_return('description')
            HelpText.should_receive(:reset_accessors)
            
            HelpText.add(:my_command, 'projects')
            HelpText.commands.should eq(
              {'projects' => [{'usage' => 'description'}]}
            )
          end
          
        end
        
        describe '.get_next_usage' do
          
          context 'with next_usage set' do
            before { HelpText.next_usage = 'foo' }
            
            it 'returns next_usage' do
              HelpText.get_next_usage.should eq('foo')
            end
          end
          
          context 'without next_usage set' do
            before do
              HelpText.next_usage = nil
              HelpText.current_command = 'bar'
            end
            
            it 'returns current_command' do
              HelpText.get_next_usage.should eq('bar')
            end
          end
          
        end
        
        describe '.get_next_description' do
          
          context 'with next_description set' do
            before { HelpText.next_description = 'foo' }
            
            it 'returns next_description' do
              HelpText.get_next_description.should eq('foo')
            end
          end
          
          context 'without next_description set' do
            before do
              HelpText.current_command = :bar
              HelpText.next_description = nil
            end
            
            it 'raises an exception' do
              expect { HelpText.get_next_description }.to raise_exception(
                'please set a description for :bar'
              )
            end
          end
        
        end
        
        describe '.reset_accessors' do
          before do
            HelpText.current_command  = 'foo'
            HelpText.next_usage       = 'foo'
            HelpText.next_description = 'foo'
          end
          
          it 'sets all accessors to nil' do
            HelpText.current_command.should eq('foo')
            HelpText.next_usage.should eq('foo')
            HelpText.next_description.should eq('foo')
            
            HelpText.reset_accessors
            
            HelpText.current_command.should be_nil
            HelpText.next_usage.should be_nil
            HelpText.next_description.should be_nil
          end
        end
          
      end
    end
  end
end