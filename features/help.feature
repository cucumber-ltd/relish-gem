Feature: Help

  The `relish help` command displays all available commands
  along with a description of each.

  Scenario: View all available commands with the help command
    When I successfully run `relish help`
    Then the output should contain:
      """
      === Available Commands
      """

  Scenario: Specifying no command runs the help command
    When I successfully run `relish`
    Then the output should contain "=== Available Commands"

  Scenario: Specifying an unknown command gives an error message
    When I run `relish baloney`
    Then it should fail with:
      """
      Unknown command. Run 'relish help' for usage information.
      """
