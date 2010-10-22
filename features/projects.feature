@announce
Feature: Projets
  In order to add and delete projects
  As a Relish user
  I want to use the projects command
  
  Background:
    Given my API token "1234" is stored
  
  Scenario: Listing all projects
    When I run relish projects --host localhost:1234
    Then it should GET to "http://localhost:1234/api/projects?api_token=1234"
  
  Scenario: Adding a project
    When I run relish projects:add rspec-core --host localhost:1234
    Then it should POST to "http://localhost:1234/api/projects?name=rspec-core&api_token=1234"
