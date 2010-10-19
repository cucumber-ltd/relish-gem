require 'spec_helper'

module Relish
  module Command
    describe Push do
      
      describe '#default' do
        let(:push) { described_class.new }
        
        it 'calls #run' do
          push.should_receive(:run)
          push.default
        end
      end
      
      describe '#url' do
        before do
          push.should_receive(:project).and_return('rspec')
          push.should_receive(:api_token).and_return('abc')
        end
        
        context 'without version' do 
          let(:push) { described_class.new }
          
          specify do
            push.url.should eq(
              "http://relishapp.com/pushes?project_id=rspec&api_token=abc"
            )
          end
        end
        
        context 'with version' do
          let(:push) { described_class.new(['--version', 'one']) }
          
          specify do
            push.url.should eq(
              "http://relishapp.com/pushes?project_id=rspec&version_id=one&api_token=abc"
            )
          end
        end
      end
      
      describe '#version' do
        context 'with --version in @options' do
          let(:push) { described_class.new(['--version', 'one']) }
          specify { push.version.should eq('one') }
        end
        
        context 'with --version not in @options' do
          let(:push) { described_class.new }
          specify { push.version.should be_nil }
        end
      end
      
      describe '#files_as_tar_gz' do
        let(:push) { described_class.new }
        specify { expect { push.files_as_tar_gz }.to_not raise_exception }
        specify { push.files_as_tar_gz.should be_a(String) }
      end
      
      describe '#files' do
        let(:push) { described_class.new }
        specify { expect { push.files }.to_not raise_exception }
        specify { push.files.should be_a(Array) }
      end
      
    end
  end
end