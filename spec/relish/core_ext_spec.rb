require 'spec_helper'

describe String do
  describe '#extract_option' do
    specify { 'foo:bar'.extract_option.should eq('bar') }
    specify { 'foo'.extract_option.should eq('foo') }
  end
  
  describe '#without_option' do
    specify { 'foo:bar'.without_option.should eq('foo') }
    specify { 'foo'.without_option.should be_nil }
  end
end