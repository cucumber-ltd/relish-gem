require 'fake_web'
FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:any, /.*/, :body => "Faked HTTP response")

When /^it should POST to "http:\/\/localhost:80([^"]*)"$/ do |path|
  request = FakeWeb.last_request
  request.path.should == path
end