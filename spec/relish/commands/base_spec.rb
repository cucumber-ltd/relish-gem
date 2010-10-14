require 'spec_helper'

module Relish
  module Command
    describe Base do
    
      {:organization => 'rspec', :project => 'rspec-core'}.each do |meth, name|
        describe "##{meth}" do
          context 'passed in command line as full arg' do
            let(:base) { described_class.new(["--#{meth}", name]) }
          
            it 'returns the value' do
              base.send(meth).should eq(name)
            end
          end
          
          context 'passed in command line as short arg' do
            let(:short_arg) { meth.to_s[0,1] }
            let(:base) { described_class.new(["-#{short_arg}", name]) }
          
            it 'returns the value' do
              base.send(meth).should eq(name)
            end
          end
          
          context 'contained in the options file' do
            let(:base) { described_class.new([]) }
            
            before do
              base.stub(:parsed_options_file).and_return({meth.to_s => name})
            end
            
            it 'returns the value' do
              base.send(meth).should eq(name)
            end
          end
        
          context 'not passed in command line' do
            let(:base) { described_class.new([]) }
          
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
          let(:base) { described_class.new(['--host', 'test.com']) }
          
          it 'returns test.com' do
            base.host.should eq('test.com')
          end
        end
        
        context 'not passed in command line' do
          let(:base) { described_class.new([]) }
          
          it 'returns the default host' do
            base.host.should eq(Base::DEFAULT_HOST)
          end
        end
      end
      
      describe '#api_token' do
        let(:base) { described_class.new([]) }
        let(:options) { {'api_token' => '12345'} }
        
        before do
          base.should_receive(:parsed_options_file).and_return(options)
        end
        
        it 'parses the api token' do
          base.api_token.should eq('12345')
        end
      end
      
      describe '#get_options' do
        let(:base) { described_class.new(['--project', 'rspec-core']) }
        let(:options) { {'project' => 'rspec-core'} }
        
        before do
          base.should_receive(:parsed_options_file).and_return(options)
        end
        
        it 'combines the args and options file' do
          base.get_options.should eq(
            {'project' => 'rspec-core', '--project' => 'rspec-core'}
          )
        end
      end
      
      describe '#parsed_options_file' do
        let(:base) { described_class.new([]) }
        
        context 'with options file that exists' do
          let(:options) do
            {'organization' => 'rspec', 'project' => 'rspec-core'}
          end
          
          before do
            File.should_receive(:exist?).twice.and_return(true)
            YAML.should_receive(:load_file).twice.and_return(options)
          end
          
          it 'parses the organization' do
            base.parsed_options_file['organization'].should eq('rspec')
          end
          
          it 'parses the project' do
            base.parsed_options_file['project'].should eq('rspec-core')
          end
        end
        
        context 'with options file that does not exist' do
          before do
            File.stub(:exist?).and_return(false)
          end
          
          it 'returns an empty hash' do
            base.parsed_options_file.should eq({})
          end
        end
      end
      
    end
  end
end