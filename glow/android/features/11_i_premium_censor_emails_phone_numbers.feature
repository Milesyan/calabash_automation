@premium @cencor
Feature: Do not let other users see the phone number and email

  @cencor_email
  Scenario: Cencor email for other users.
    Given A premium user sent chat request to a new user "Albert"
    And I wait for 2 seconds for the next page
  @cencor_phone_number  
  Scenario: Cencor phone number for other users.
    Given A premium user sent chat request to a new user "Albert"
