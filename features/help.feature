@announce
Feature: Help
  
  The `relish help` command displays all available commands
  along with a description of each.
  
  The `relish projects --help' option will display help text
  for that particular command.
  
  Scenario: View all available commands with the help command
    When I successfully run "relish help"
    Then the output should contain exactly:
      """
      === Available Commands

      help                                                           # show this usage
      config                                                         # display the contents of your options file
      config:show                                                    # display the contents of your options file
      config:add --<option> <value>                                  # add a configuration option to your options file
      projects                                                       # list your projects
      projects:list                                                  # list your projects
      projects:add <organization_or_user_handle>/<project_handle>    # add a project
      projects:remove <organization_or_user_handle>/<project_handle> # remove a project
      push                                                           # push your features to relishapp.com
      
      """