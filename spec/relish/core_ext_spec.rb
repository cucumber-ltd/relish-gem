require 'spec_helper'

describe String do
  describe '#extract_option' do
    specify { 'foo:bar'.extract_option.should eq('bar') }
  end
  
  describe '#remove_option' do
    specify { 'foo:bar'.remove_option.should eq('foo') }
  end
end