@community
Feature: Create topic with short/empty title or body
	Scenario: Create a Poll topic
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I touch "Community"
		And I touch "Poll"
		Then I see "Done" button is not enable
		And I fill in a "short" title
		And I fill in a "short" answer
		And I fill in a "short" content
		And I touch glow done
		Then I should see text containing "Title is too short"
		And I fill in a "long" title
		And I touch glow done
		And I choose the group
		Then I should see text containing "Your Poll is successfully posted"
	
	Scenario: Create a Post topic
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I touch "Community"
		And I touch "Post"
		Then I see "Done" button is not enable
		And I fill in a "short" title
		And I fill in a "short" content
		And I touch glow done
		Then I should see text containing "Title is too short"
		And I fill in a "long" title
		And I touch glow done
		Then I should see text containing "content is too short"
		And I fill in a "long" content
		And I touch glow done
		And I choose the group
		Then I should see text containing "Your Post is successfully posted"