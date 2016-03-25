@forum @search_topics_comments
Feature: Add topics and comments and user search for it.
  @search_topics  
  Scenario: User create some topics and search between them.
    Given I create a new forum user with name "Paddington"
    And "Paddington" create 10 topics for searching topic
    And I login as the new user "Paddington" created through www
    And I open "community" page
    And I go to search bar
    And I search the topic in the first step
    Then I should see the search result for topic
    And I return to group page from search result
    And I logout


  @search_comments
  Scenario: User create 1 topic and some comments.
    Given I create a new forum user with name "Winnie"
    And "Winnie" create 1 topic and 10 comments and 0 subreplies for each comment
    And I login as the new user "Winnie" created through www
    And I open "community" page
    And I go to search bar
    And I click search for comment 
    Then I check the search result for comment
    And I return to group page from search result
    And I logout

  @search_subreply 
  Scenario: User create 1 topic 1 comment and some sub replies. 
    Given I create a new forum user with name "June"
    And "June" create 1 topic and 2 comments and 10 subreplies for each comment
    And I login as the new user "June" created through www
    And I open "community" page
    And I go to search bar
    And I click search for subreply
    Then I check the search result for sub-reply    
    And I go back to group
    And I return to group page from search result
    And I logout

  @search_deleted_comment 
  Scenario: User create 1 topic 1 comment and delete the topic and search the comment.
	Given I create a new forum user with name "Devil"
    And "Devil" create topics and comments and replies for delete use
    And I login as the new user "Devil" created through www
    And I open "community" page
    And I go to search bar
    Then I click search for deleted "comment"
    Then I check the search result for deleted "comment"
    And I return to group page from search result after search deleted comment
    And I logout

  @search_deleted_subreply
  Scenario: User create 1 topic 1 comment 1 subreply and delete the topic, and search the subreply.
    Given I create a new forum user with name "Devil"
    And "Devil" create topics and comments and replies for delete use
    And I login as the new user "Devil" created through www
    And I open "community" page
    And I go to search bar
    Then I click search for deleted "reply"
    Then I check the search result for deleted "reply"
    And I return to group page from search result after search deleted comment
    And I logout

  @search_groups
  Scenario: User create a group and search it
    Given I create a new forum user with name "Miles"
    And "Miles" create a group in category "Baby" with name "SearchGroup"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to search bar
    Then I test search group function
    And I click cancel button
    And I logout