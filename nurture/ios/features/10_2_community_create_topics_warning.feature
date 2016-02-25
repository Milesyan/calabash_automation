@forum @create_topics_warning
Feature: User create topics with warning messages

    @create_topics_warning
    Scenario: User create a text topic with short title
    Given I create a new nurture user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I post a text topic with title "a"
    Then I discard the topic 
    And I post a text topic with title "a long topic"
    Then I should see the topic is posted successfully
    And I logout


