@forum @create_topics
Feature: User create text/poll/image/url topics
	
	@create_post
	Scenario: User create a text topic
		Given I create a new "ttc" user
		Then I login as the new user or default user
    And I open "community" page
    And I post a "text" topic
    Then I should see the topic is posted successfully
    And I logout

	@create_poll
	Scenario: User create a poll topic
		Given I create a new "non-ttc" user
		Then I login as the new user or default user
    And I open "community" page
    And I post a "poll" topic
    Then I should see the topic is posted successfully
    And I logout

  @create_link
	Scenario: User create a link topic
		Given I create a new "ttc" user
		Then I login as the new user or default user
    And I open "community" page
    And I post a "link" topic
    Then I should see the topic is posted successfully
    And I logout

  @create_post_in_group
  Scenario: User create a text topic in group
  	Given I login as the new user or default user
    And I open "community" page
    Then I go to the first group
    And I post a text topic with title "Post in group topic"
    Then I should see the topic is posted successfully
    And I logout

  # @create_image 
  # Scenario: User create a image topic
		# Given I create a new "ttc" user
		# Then I login as the new user
  #   And I open "community" page
  #   And I post a "image" topic
  #   And I logout 