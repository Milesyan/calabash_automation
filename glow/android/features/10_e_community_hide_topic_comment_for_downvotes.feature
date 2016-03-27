@forum @hide_topic/comment_by_downvote
Feature: User downvote or flag topics to make it hidden.
  @hidden_by_downvote_topic
  Scenario: User create a topic and other users downvote it to make it hidden.
    Given I create a new forum user with name "Miles"
    And "Miles" create 1 topic and 10 comments and 3 subreplies for each comment
    And 1 other users upvote the topic and 3 other users downvote the topic
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    Then I should see the content hidden due to low rating
    And I touch "View Rules" in auto-hidden topic
    Then I should see "Rules" in my view
    And I go back to previous page
    And I go to the first group
    And I touch "Show Content" in auto-hidden topic
    And I enter topic created in previous step
    Then I should see "Show entire discussion" in my view
    And I go back to group
    And I logout

  @hidden_by_report_topic
  Scenario: User create a topic and other users report it to make it hidden.
    Given I create a new forum user with name "Miles"
    And "Miles" create 1 topic and 10 comments and 3 subreplies for each comment
    And 3 other users reported the topic
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    Then I should see the content hidden due to low rating
    And I touch "View Rules" in auto-hidden topic
    Then I should see "Rules" in my view
    And I go back to previous page
    And I go to the first group
    And I touch "Show Content" in auto-hidden topic
    And I enter topic created in previous step
    Then I should see "Show entire discussion" in my view
    And I go back to group
    And I logout

  @hidden_by_downvote_comment
  Scenario: User create a comment and other users downvote it to make it hidden.
    Given I create a new forum user with name "Miles"
    And "Miles" create 1 topic and 1 comment and 3 subreplies for each comment
    And 1 other users upvote the comment and 3 other users downvote the comment
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter topic created in previous step
    Then I should see the content hidden due to low rating
    And I touch "View Rules" in auto-hidden topic
    Then I should see "Rules" in my view
    And I go back to previous page
    And I touch "Show Content" in auto-hidden topic
    Then I wait to see comment contains "comment 1"
    And I go back to group
    And I logout

  @hidden_by_report_comment
  Scenario: User create a comment and other users report it to make it hidden.
    Given I create a new forum user with name "Miles"
    And "Miles" create 1 topics and 1 comments and 3 subreply for each comment
    And 3 other users reported the comment
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter topic created in previous step
    Then I should see the content hidden due to low rating
    And I touch "View Rules" in auto-hidden topic
    Then I should see "Rules" in my view 
    And I go back to previous page
    And I touch "Show Content" in auto-hidden topic
    Then I wait to see comment contains "comment 1"
    And I go back to group
    And I logout