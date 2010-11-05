require 'spec_helper'

module Relish
  module Command
    describe Base do
    
      {:organization => 'rspec', :project => 'rspec-core'}.each do |meth, name|
        describe "##{meth}" do
          context 'passed in command line' do
            let(:base) { described_class.new(["--#{meth}", name]) }
          
            it 'returns the value' do
              base.send(meth).should eq(name)
            end
          end
          
          context 'contained in the options file' do
            let(:base) { described_class.new }
            
            before do
              base.stub(:parsed_options_file).and_return({meth.to_s => name})
            end
            
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
      
      describe '#url' do
        context 'host passed in command line' do
          let(:base) { described_class.new(['--host', 'test.com']) }
          specify { base.url.should eq('http://test.com/api') }
        end
        
        context 'host not passed in command line' do
          let(:base) { described_class.new }
          
          it 'returns the default host' do
            base.url.should eq("http://#{Base::DEFAULT_HOST}/api")
          end
        end
      end
      
      describe '#resource' do
        let(:base) { described_class.new }
        
        before do
          base.should_receive(:url).and_return('url')
          RestClient::Resource.should_receive(:new).with('url')
        end
        
        specify { base.resource }
      end
      
      describe '#api_token' do
        let(:base) { described_class.new }
        before { base.stub(:parsed_options_file).and_return(options) }
        
        context "when the token is stored locally" do
          let(:options) { {'api_token' => '12345'} }
          
          it 'parses the api token' do
            base.api_token.should eq('12345')
          end
        end
        
        context "when the token is not stored locally" do
          let(:options) { {} }
          
          it "asks the user for their credentials" do
            base.should_receive(:get_api_credentials)
            base.api_token
          end
        end
        
      end
      
      describe '#get_param' do
        
        context 'given a command param' do
          let(:base) do
            base = described_class.new
            base.args = ['param', '--project', 'rspec-core']
            base
          end
          
          it 'returns the first arg' do
            base.get_param.should eq('param')
          end
        end
        
        context 'not given a command param' do
          let(:base) do
            base = described_class.new
            base.args = ['--project', 'rspec-core']
            base
          end
          
          it 'returns nil' do
            base.get_param.should be_nil
          end
        end
      end
      
      describe '#get_options' do
        let(:options) { {'project' => 'rspec-core'} }
        let(:base) { described_class.new(['--project', 'rspec-core']) }
        
        before do
          base.should_receive(:parsed_options_file).and_return(options)
        end
      
        it 'combines the args and options file' do
          base.get_options.should eq(
            {'project' => 'rspec-core'}
          )
        end
      end
      
      describe '#parsed_options_file' do
        let(:base) { described_class.new }
        
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