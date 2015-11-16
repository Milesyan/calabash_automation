@community
@community1
Feature: create different kinds of topics
	Scenario:Create a Poll topic
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I post a "poll" topic
		And I choose the group
		Then I should see text containing "Your Poll is successfully posted"

	Scenario:Create a Post topic
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I post a "post" topic
		And I choose the group
		Then I should see text containing "Your Post is successfully posted"

	Scenario:Create a Poll topic
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I post a "photo" topic
		And I choose the group
		Then I should see text containing "Your Photo is successfully posted"

	Scenario:Create a Link topic
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I post a "link" topic
		And I choose the group
		Then I should see text containing "Your Link is successfully posted"
