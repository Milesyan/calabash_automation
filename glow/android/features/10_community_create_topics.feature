@community
Feature: create different kinds of topics
	Scenario:Create a Poll topic
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I touch "Community"
		And I touch "Poll"
		And I fill in the contents in "Poll" page
		And I choose the group
		Then I should see text containing "Your Poll is successfully posted"
	Scenario:Create a Post topic
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I touch "Community"
		And I touch "Post"
		And I fill in the contents in "Post" page
		And I choose the group
		Then I should see text containing "Your Post is successfully posted"

	Scenario:Create a Poll topic
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I touch "Community"
		And I touch "Photo"
		And I fill in the contents in "Photo" page
		And I choose the group
		Then I should see text containing "Your Photo is successfully posted"

	Scenario:Create a Link topic
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I touch "Community"
		And I touch "Link"
		And I fill in the contents in "Link" page
		And I choose the group
		Then I should see text containing "Your Link is successfully posted"
