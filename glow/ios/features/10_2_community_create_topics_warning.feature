@forum @create_topics_warning
Feature: User create topics with warning messages
	
	Scenario: User create a text topic with short title
		Given I create a new "ttc" user
		Then I login as the new user or default user
    And I open "community" page
    Then I go to the first group
    And I post a text topic with title "a"
    Then I discard the topic 
    And I post a text topic with title "a long topic"
    Then I should see the topic is posted successfully
    And I logout


