@community
Feature: edit topics
	
	Scenario: create a post topic and edit it.
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I touch "Community"
		And I select the "4" group
		And I touch "Post"
		And I fill in the contents in "Post" page
		Then I should see text containing "Your Post is successfully posted"
		Then I wait for 2 seconds
		Then I touch the "post" I created
		Then I touch topic menu button
		Then I touch Edit this post tab
		And I fill in a "edit topic" title
		And I fill in a "edit content" content
		Then I touch glow done
		Then I should see text containing "Success"
	
	Scenario: create a poll and edit it.
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I touch "Community"
		And I select the "4" group
		And I touch "Poll"
		And I fill in the contents in "Poll" page
		Then I should see text containing "Your Poll is successfully posted"
		Then I wait for 2 seconds
		Then I touch the "Poll" I created
		Then I touch topic menu button
		Then I touch Edit this post tab
		And I fill in a "edit topic" title
		And I fill in a "edit poll" answer
		And I fill in a "edit content" content
		Then I touch glow done
		Then I should see text containing "Success"
	@debug
	Scenario: create a link and edit it.
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I touch "Community"
		And I select the "4" group
		And I touch "Link"
		And I fill in the contents in "Link" page
		Then I should see text containing "Your Link is successfully posted"
		Then I wait for 2 seconds
		Then I touch the "Link" I created
		Then I touch topic menu button
		Then I touch Edit this post tab
		And I fill in a "edit topic" title
		And I fill in a "www.baidu.com" content
		And I wait for 3 seconds
		Then I touch glow done
		Then I should see text containing "Success"