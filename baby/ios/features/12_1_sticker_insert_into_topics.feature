@not_ready
Feature: Free user inserts stickers into topics.
  Scenario: Insert stickers into post topic.
    Given I create a new forum user with name "Ronald"
    And I login as the new user "Ronald" created through www
    And I open "community" page
    And I go to the first group 
    And I click create post button and enter some text
    When I click add sticker button 
    Then I should see the select sticker page
    And I choose a free pack
    When I click to add a sticker into the topic
    Then I should see the sticker is added into the topic successfully
    And I click post to post the topic
    Then I should see the topic is posted successfully 
    Then I should see the sticker in my post
    And I go back to previous page 
    And I logout 

  Scenario: Premium user inserts stickers into post topic.
    Given A premium user and a non-premium user have been created for test
    And I login as premium user
    And I open "community" page
    And I go to the first group 
    And I click create post button and enter some text
    When I click add sticker button 
    Then I should see the select sticker page
    And I choose a premium pack
    When I click to add a sticker into the topic
    Then I should see the sticker is added into the topic successfully
    And I click post to post the topic
    Then I should see the topic is posted successfully 
    Then I should see the sticker in my post
    And I go back to previous page 
    And I logout 

  Scenario: Premium user inserts stickers into photo topic.
    Given A premium user and a non-premium user have been created for test
    And I login as premium user 
    And I open "community" page
    And I go to the first group
    And I click create photo button and enter some text
    When I click add sticker button
    Then I should see the select sticker page
    And I choose an a la carte pack
    When I click to add a sticker into the topic
    Then I should see the sticker is added into the topic successfully
    And I click post to post the topic
    Then I should see the topic is posted successfully 
    Then I should see the sticker in my post
    And I go back to previous page 
    And I logout 

  Scenario: A la carte user insert stickers into poll topic.
    Given An a la carte user "Smith" has been created 
    And I login as the new user
    And I open "community" page
    And I go to the first group
    And I click create poll button and enter some text
    When I click add sticker button
    Then I should see the select sticker page
    And I choose an a la carte pack
    When I click to add a sticker into the topic
    Then I should see the sticker is added into the topic successfully
    And I click post to post the topic
    Then I should see the topic is posted successfully 
    Then I should see the sticker in my post
    And I go back to previous page 
    And I logout 

  Scenario: A user can only insert one sticker 
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I click create post button and enter some text
    And I insert a sticker in the post
    Then I should not add another sticker
    And I logout
    

  Scenario: A user can insert sticker above text
    Given I create a new forum user with name "Ronald"
    And I login as the new user "Ronald" created through www
    And I open "community" page
    And I go to the first group 
    And I click create post button and enter some text
    When I click add sticker button 
    Then I should see the select sticker page
    And I choose a free pack
    When I click to add a sticker into the topic
    Then I should see the sticker is added into the topic successfully
    When I inserted some texts after the topic
    And I click post to post the topic
    Then I should see the topic is posted successfully 
    Then I should see the sticker in my post
    And I check the sticker between the text looks well
    And I go back to previous page 
    And I logout 





