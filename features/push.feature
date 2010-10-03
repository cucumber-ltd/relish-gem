Feature: Push
  In order to send my features to relishapp
  As a dev
  I want to push
  
  Scenario: Specify everything at the command-line
    When I run "relish push --host localhost:101 --project rspec-core --user rspec"
    When it should POST to "http://localhost:101/rspec/rspec-core"

  
  

  
