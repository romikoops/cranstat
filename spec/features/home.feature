@home_steps
Feature: Home Page

  Scenario: User can see package list when data present
    Given there are some test packages
    When I open home page
    Then I should see the test packages

  Scenario: User can not see package list when no data
    When I open home page
    Then I should no see any test packages
