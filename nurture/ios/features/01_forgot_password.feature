Feature: Forgot password
  @forgot_password
  Scenario: Forgot password
    Given I am an existing user "rachel_glow@yahoo.com"
    And I open the login scree
    And I input wrong email and password
    #Then I should see "This is the wrong email and password combination."
    And I touch "Forgot password" link
    And I send the forgot password request
    #Then I should see "Email sent, please check your mail box."