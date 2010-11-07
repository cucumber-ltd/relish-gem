require 'spec_helper'

describe Relish do
  it "has a .global_options_file setting" do
    Relish.global_options_file.should_not be_nil
  end
  
  it "allows global_options_file to be overwritten" do
    Relish.global_options_file = 'foo'
    Relish.global_options_file.should == 'foo'
  end
end
