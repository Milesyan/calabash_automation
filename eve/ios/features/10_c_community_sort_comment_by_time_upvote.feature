@forum @order_by @restart
Feature: Test order by time and order by upvote.
  Scenario: User create a topic and switch between order by time and upvote.
    Given I create a new forum user with name "Miles"
    And "Miles" create 1 topic and 10 comments and 3 subreplies for each comment
    And the user upvote the first comment
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter topic created in previous step
    Then I should see "Show entire discussion" in my view
    And I should see the last comment
    And I expand all the comments
    And I click the hyperlink of comments
    Then I should see "✓ Sort by Upvotes" in my view
    And I should see "Sort by Time" in my view
    And I should see "Cancel" in my view
    And I touch "Sort by Time" link
    Then I wait to see comment contains "comment 10"
    And I click the hyperlink of comments
    And I touch "Sort by Upvotes" button
    Then I wait to see comment contains "comment 1"
    And I go back to group
    And I logout
