Feature: create different kinds of topics
	
	Scenario:Create a text topic
		Given I log in as "miles@glowing.com"
		Then a go to community page
		And I touch "Community"
		And I touch "Poll"
		And I fill in the contents in Poll page
		Then I touch "Done"
		And I choose the group
		Then I see " You successfully..."

