require 'fake_web'
FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:any, /.*/, :body => "Faked HTTP response")

When /^it should POST to "http:\/\/localhost:1234([^"]*)"$/ do |path|
  request = FakeWeb.last_request || raise("Fakeweb did not record a request.")
  request.path.should == path
end