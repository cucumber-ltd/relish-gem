@announce
Feature: Help
  
  The `relish help` command displays all available commands
  along with a description of each.
  
  Scenario: View all available commands with the help command
    When I successfully run "relish help"
    Then the output should contain exactly:
      """
      A <project> can be scoped by an organization or user handle. For
      example, if an organiztion (rspec) has a project (rspec-core), then
      the <project> would be `rspec/rspec-core`. If a user (justin) has a
      project (my-project), then <project> would be `justin/my-project`.

      If you leave off the organization or user handle, then it defaults
      to the user (you).
      
      === Available Commands

      help                                                   # show this usage
      config                                                 # display the contents of your options file
      config:add <option>:<value>                            # add a configuration option to your options file
                                                             # example: relish config:add project:rspec-core
                                                             # valid configuration options: project
      projects                                               # list your projects
      projects:add <org_or_user_handle>/<project_handle>     # add a project
                                                             # append :private to make the project private
                                                             # example: relish projects:add rspec/rspec-core:private
      projects:remove <project_handle>                       # remove a project
      push <project>                                         # push features to relishapp.com
      collab                                                 # list the collaborators for a project
      collab:add <project>:<collaborator_handle_or_email>    # add a collaborator to a project
                                                             # example: relish collab:add rspec/rspec-core:justin
      collab:remove <project>:<collaborator_handle_or_email> # remove a collaborator from a project
                                                             # example: relish collab:remove rspec/rspec-core:justin
      
      """
      
  Scenario: Specifying no command runs the help command
    When I successfully run "relish"
    Then the output should contain "=== Available Commands"
    
  Scenario: Specifying an unknown command gives an error message
    When I run "relish baloney"
    Then it should fail with:
      """
      Unknown command. Run 'relish help' for usage information.
      """