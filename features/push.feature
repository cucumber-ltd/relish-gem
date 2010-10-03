@announce
Feature: Push
  In order to send my features to relishapp.com
  As a Relish user dev
  I want a push command
  
  Scenario: Specify everything at the command-line
    When I run "relish push --host localhost:80 --project rspec-core --user rspec"
    When it should POST to "http://localhost:80/rspec/rspec-core"
