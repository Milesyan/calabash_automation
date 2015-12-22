@regression
Feature: Forgot password
  @forgot_password
  Scenario: Forgot password
    Given I create a new "TTC" glow user
    And I open the login screen
    And I input wrong email and password
    Then I should see "Wrong email and password combination."
    And I touch "OK" button
    And I open forgot password screen
    And I input my email "rachel_glow@yahoo.com" and send
    Then I should see "An email has been sent to your email address, please check the email on this device."
    And I touch "OK" button
