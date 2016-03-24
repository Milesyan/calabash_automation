@forum @hide_report 
Feature: Test hide/report topic/comment (4m40.131s 4 scenarios 38 steps)
  @hide_topic
  Scenario: User create a topic and hide it.
    Given I create a new forum user with name "Miles"
    And another user "Charlotte" create 1 topic and 2 comments and 3 subreplies for each comment
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter topic created by another user
    Then I hide the topic
    Then I should not see the topic hidden by me
    And I logout

  @report_topic
  Scenario: User create a topic and hide it @report_topic
    Given I create a new forum user with name "Miles"
    And another user "Charlotte" create 1 topic and 1 comment and 1 subreply for each comment
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter topic created by another user
    And I report the topic by reason "Wrong group"
    Then I should still see the topic
    And I report the topic by reason "Spam"
    And I click confirm to hide it
    Then I should not see the topic hidden by me
    And I logout

  @hide_comment
  Scenario: User create a topic and hide it @hide_comment
    Given I create a new forum user with name "Miles"
    And another user "Charlotte" create 1 topic and 1 comment and 1 subreply for each comment
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter topic created by another user
    Then I hide the comment
    Then I should not see the comment hidden by me
    Then I go back to previous page
    And I logout

  @report_comment
  Scenario: User create a topic and hide it @report_comment
    Given I create a new forum user with name "Miles"
    And another user "Charlotte" create 1 topic and 1 comment and 1 subreply for each comment
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter topic created by another user
    And I report the comment by reason "Spam"
    And I click confirm to hide it
    Then I should not see the comment hidden by me
    And I go back to previous page
    And I logout

  @report_reason @wip
  Scenario: Check report topic and report comment reasons, and report by other reason.
    Given another user "Charlotte" create 1 topic and 1 comment and 1 subreply for each comment
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter topic created by another user
    Then I click to report the "topic" and check the reasons:
      |Topic flag reasons|
      |Wrong group  |
      |Rude         |
      |Obscene      |
      |Spam         |
      |Solicitation |
      |Other        |
      |Cancel       |
    And I report the topic by reason "Other"
    And I type in report reason and click flag
    And I click confirm not to hide it
    Then I should still see the topic
    And I click to report the "comment" and check the reasons:
      |Comment flag reasons|
      |Rude|
      |Obscene|
      |Spam|
      |Solicitation|
      |Other|
      |Cancel|
    And I report the comment by reason "Other"
    And I type in report reason and click flag
    And I click confirm not to hide it
    Then I should still see the comment
    And I go back to previous page
    And I logout