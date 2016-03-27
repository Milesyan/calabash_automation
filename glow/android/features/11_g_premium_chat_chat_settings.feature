@premium @chat_setting
Feature: Check function in chat settings

  @delete_chat_history
  Scenario: Check delete chat history.
    Given A premium user milesp established chat relationship with a new user "Holmes"
    And I login as premium user
    And I open "community" page
    And I go to messages 
    And I go to the chat window for the new user
    Then I send a message with text "test delete history"
    And I click chat settings 
    When I click "Delete chat history" in chat options
    Then I should see the chat history has been deleted
    And I click done to close messages
    And I logout


  # @show_all_images
  # Scenario: Check show all images (Not in iOS)
  #   Given A premium user milesp established chat relationship with a new user "Holmes"
  #   And I login as premium user
  #   And I open "community" page
  #   And I go to messages 
  #   And I go to the chat window for the new user
  #   Then I send a message with last image
  #   And I click chat settings 
  #   When I click "Show all images" in chat options
  #   Then I should see the image I sent
  #   And I click done to close messages
  #   And I logout


  @block_user
  Scenario: Check block user
    Given A premium user milesp established chat relationship with a new user "Holmes"
    And I login as premium user
    And I open "community" page
    And I go to messages 
    And I go to the chat window for the new user
    And I click chat settings 
    And I click "Block user" in chat options
    Then I confirm to block the user
    And I go back to previous page
    Then I click done to close messages
    Then I go to community settings page
    And I go to blocked users part under community settings
    Then I can see the person I blocked
    Then I exit blocking users page
    And I click back button in the community settings page
    And I logout

  @delete_user
  Scenario: Check delete user
    Given A premium user milesp established chat relationship with a new user "Holmes"
    And I login as premium user
    And I open "community" page
    And I go to messages 
    And I go to the chat window for the new user
    And I click chat settings 
    When I click "Delete user" in chat options
    Then I confirm to delete the user
    And I click done to close messages
    And I logout

  @report_user
  Scenario: Check report user
    Given A premium user milesp established chat relationship with a new user "Holmes"
    And I login as premium user
    And I open "community" page
    And I go to messages 
    And I go to the chat window for the new user
    And I click chat settings 
    When I click "Report user" in chat options
    Then I choose one of the reasons as report reason
    And I go back to previous page
    And I click done to close messages
    And I logout