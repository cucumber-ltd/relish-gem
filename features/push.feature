@announce
Feature: Push
  In order to send my features to relishapp.com
  As a Relish user dev
  I want a push command
  
  Background:
    Given my API token "1234" is stored
  
  Scenario: Specify everything at the command-line
    When I run relish push --host localhost:1234 --project p
    Then it should POST to "http://localhost:1234/api/pushes?project_id=p&api_token=1234"
