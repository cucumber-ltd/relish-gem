require 'spec_helper'

module Relish
  describe OptionsFile do
    let(:path) { Dir.tmpdir + '/.relish' }
    let(:global_options) { described_class.new(path) }
  
    after { FileUtils.rm_rf(path) }
  
    describe '#[]' do
    
      context 'with options file that exists' do
        let(:options) do
          {'organization' => 'rspec', 'project' => 'rspec-core'}
        end
      
        before do
          File.open(path, 'w') { |f| YAML.dump(options, f) }
        end
      
        it 'parses the organization' do
          global_options['organization'].should eq('rspec')
        end
      
        it 'parses the project' do
          global_options['project'].should eq('rspec-core')
        end
      end
    
      context 'with options file that does not exist' do
        before do
          FileUtils.rm_rf(path)
        end
      
        it 'returns an empty hash' do
          global_options.should eq({})
        end
      end
    end
  
    describe '#store' do
      context 'with options file that exists' do
      
        let(:options) do
          {'organization' => 'rspec', 'project' => 'rspec-core'}
        end
      
        before do
          File.open(path, 'w') { |f| YAML.dump(options, f) }
          global_options.store('organization' => 'relish')
        end
      
        it "over-writes existing values" do
          OptionsFile.new(path).options['organization'].should == 'relish'
        end
      
        it 'leaves existing options alone' do
          OptionsFile.new(path).options['project'].should == 'rspec-core'
        end 
      
      end
    end
  
  end
end