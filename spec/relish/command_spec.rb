require 'spec_helper'

describe Relish::Command do
  
  it "recognizes the 'push' command" do
    push = double
    push.should_receive(:default)
    Relish::Command::Push.should_receive(:new).with([]).and_return(push)
    Relish::Command.run('push', [])
  end
  
  it "recognizes the 'config' command" do
    config = double
    config.should_receive(:default)
    Relish::Command::Config.should_receive(:new).with([]).and_return(config)
    Relish::Command.run('config', [])
  end
  
  it "recognizes the 'projects' command" do
    projects = double
    projects.should_receive(:default)
    Relish::Command::Projects.should_receive(:new).with([]).and_return(projects)
    Relish::Command.run('projects', [])
  end
  
end