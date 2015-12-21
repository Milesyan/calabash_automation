@forum @search_topics_comments
Feature: Add topics and comments and user search for it.
  @search_topics  
  Scenario: User create some topics and search between them
    Given I create a new user and create 5 topics for search topics
    Then I login as the new user or default user
    And I open "community" page
    Then I go to search bar
    Then I search the topic "in the first step"
    Then I should see the search result
    Then I return to group page from search result
    Then I logout


  @search_comments
  Scenario: User create 1 topic and some comments
    Given I create a new user and create 1 topics and 10 comments and 0 subreply for each comments
    Then I login as the new user or default user
    And I open "community" page
    Then I go to search bar
    Then I click search for comment "Test search comment"
    Then I check the search result for comment "Test search comment"
    Then I return to group page from search result
    Then I logout

  @search_subreply  @debug
  Scenario: User create 1 topic 1 comment and some sub replies
    Given I create a new user and create 1 topics and 2 comments and 10 subreply for each comments
    Then I login as the new user or default user
    And I open "community" page
    Then I go to search bar
    Then I click search for comment "Test search sub-reply"
    Then I check the search result for sub-reply "Test search sub-reply"
    Then I go back to group
    Then I return to group page from search result
    Then I logout

  @search_deleted_comment
  Scenario: User create 1 topic 1 comment and delete the topic
		Given I create a new user and create topics and comments and replies for delete use
    Then I login as the new user or default user
    And I open "community" page
    Then I go to search bar
    Then I click search for special comment
    Then I check the search result for special comment
    Then I return to group page from search result
    Then I logout

