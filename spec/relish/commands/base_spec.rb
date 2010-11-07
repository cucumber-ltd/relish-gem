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
      
      describe '#api_token' do
        let(:base) { described_class.new }
        let(:ui)   { double(Ui) }

        before do
          Ui.stub(:new).and_return(ui)
          base.stub(:parsed_options_file).and_return(options)
        end
        
        context "when the token is stored locally" do
          let(:options) { {'api_token' => '12345'} }
          
          it 'parses the api token' do
            base.api_token.should eq('12345')
          end
        end

        context "when the token is not stored locally" do
          let(:options)     { {} }
          let(:api_token)   { 'abasfawer23123' }
          let(:credentials) { ['testuser', 'testpassword'] }
          
          let(:global_options) do
            double = double(OptionsFile)
            OptionsFile.stub(:new => double)
            double
          end
          
          def api_endpoint(name, credentials)
            user, password = *credentials
            endpoint = double

            RestClient::Resource.stub(:new).
              with(anything, :user => user, :password => password).
              and_return name => endpoint
    
            endpoint
          end
          
          it "asks the user for their credentials and send them to the server" do
            ui.should_receive(:get_credentials).and_return(credentials)
            api_endpoint('token', credentials).should_receive(:get).and_return(api_token)
            global_options.should_receive(:store).with 'api_token' => api_token
            
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
      
    end
  end
end