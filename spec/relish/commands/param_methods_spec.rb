require 'spec_helper'

module Relish
  module Command
    describe ParamMethods do
      let(:foo_bar) { 'foo:bar'.extend(described_class) }
      let(:foo) { 'foo'.extend(described_class) }
      
      describe '#extract_option' do
        specify { foo_bar.extract_option.should eq('bar') }
        specify { foo.extract_option.should eq('foo') }
      end

      describe '#without_option' do
        specify { foo_bar.without_option.should eq('foo') }
        specify { foo.without_option.should eq('foo') }
      end

      describe '#has_option?' do
        specify { foo_bar.has_option?.should be_true }
        specify { foo.has_option?.should be_false }
      end
      
    end
  end
end