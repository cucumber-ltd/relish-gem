require 'spec_helper'

module Relish
  module Command
    describe Base do
      
      {:account => 'rspec', :project => 'rspec-core'}.each do |meth, name|
        describe "##{meth}" do
          context 'passed in command line' do
            let(:base) { described_class.new({meth => name}) }
          
            it 'returns the value' do
              base.send(meth).should eq(name)
            end
          end
        
          context 'not passed in command line' do
            let(:base) { described_class.new }
          
            context 'and options file does not exist' do
              it 'returns nil' do
                base.send(meth).should be_nil
              end
            end
          end
        end
      end
      
      describe '#host' do
        context 'passed in command line' do
          let(:base) { described_class.new({:host => 'test.com'}) }
          
          it 'returns test.com' do
            base.host.should eq('test.com')
          end
        end
        
        context 'not passed in command line' do
          let(:base) { described_class.new }
          
          it 'returns the default host' do
            base.host.should eq(Base::DEFAULT_HOST)
          end
        end
      end
      
      describe '#parse_options_file' do
        let(:base) { described_class.new }
        
        context 'with options file that exists' do
          let(:options) do
            '--account rspec --project rspec-core'
          end
          
          before do
            File.stub(:exist?).and_return(true)
            File.stub(:read).and_return(options)
          end
          
          it 'parses the account' do
            base.parse_options_file[:account].should eq('rspec')
          end
          
          it 'parses the project' do
            base.parse_options_file[:project].should eq('rspec-core')
          end
        end
        
        context 'with options file that does not exist' do
          before do
            File.stub(:exist?).and_return(false)
          end
          
          it 'returns an empty hash' do
            base.parse_options_file.should eq({})
          end
        end
      end
      
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