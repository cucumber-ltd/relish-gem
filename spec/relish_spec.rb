require 'spec_helper'

describe Relish do

  it "has a .global_options_file setting" do
    Relish.global_options_file.should_not be_nil
  end

  context "when $HOME is not set" do
    before do
      @original_home = ENV['HOME']
      ENV['HOME'] = nil
      Object.send(:remove_const, :Relish)
      load 'lib/relish.rb'
    end

    after do
      ENV['HOME'] = @original_home
    end

    it "returns a non-expanded path to ~/.relish" do
      Relish.global_options_file.should == '~/.relish'
    end
  end

  it "allows global_options_file to be overwritten" do
    Relish.global_options_file = 'foo'
    Relish.global_options_file.should == 'foo'
  end
end
