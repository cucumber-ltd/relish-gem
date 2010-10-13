Given /^my API token "([^"]*)" is stored$/ do |api_token|
  # yeah! dirty hack
  Relish::Command::Base.class_eval do
    define_method(:api_token) { api_token }
  end
end