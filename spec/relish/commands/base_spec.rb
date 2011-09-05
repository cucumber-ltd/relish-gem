require 'spec_helper'

module Relish
  module Command
    describe Base do
      
      describe '#url' do
        context 'host passed in command line' do
          let(:base) { described_class.new(['--host', 'test.com']) }
          specify { base.url.should eq('https://test.com/api') }
        end
        
        context 'host not passed in command line' do
          let(:base) { described_class.new }
          
          it 'returns the default host' do
            base.url.should eq("https://#{Relish.default_host}/api")
          end
        end

        context '--ssl off switch passed' do
          let(:base) { described_class.new(['--ssl', 'off']) }
          specify { base.url.should =~ /^http:/ }
        end

      end
      
      describe '#api_token' do
        let(:base) { described_class.new }
        let(:ui)   { double(Ui) }

        before do
          Ui.stub(:new).and_return(ui)
          OptionsFile.stub(:new => options)
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
            double = double(OptionsFile, :[] => nil)
            OptionsFile.stub(:new => double)
            double
          end
          
          def api_endpoint(name, credentials)
            user, password = *credentials
            endpoint = double

            RestClient::Resource.stub(:new).
              with(anything, :user => user, :password => password, :headers => anything).
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
