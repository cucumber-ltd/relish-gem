require 'spec_helper'

describe Relish::Command do
  
  it "recognizes the 'push' command" do
    push = double
    push.should_receive(:default)
    Relish::Command::Push.should_receive(:new).with([]).and_return(push)
    Relish::Command.run('push', [])
  end
  
end