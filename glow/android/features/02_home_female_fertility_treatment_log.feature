@ft_log
Feature: Complete fertility treatment log
	@iui_ft_log
	Scenario: IUI user completes ft log
		Given I register a new "IUI" user
	    And I complete ft log
		And I logout