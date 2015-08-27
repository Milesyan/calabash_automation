@ft_log
Feature: Complete fertility treatment log
	@iui_ft_log
	Scenario: IUI user completes ft log
		Given I register a new "IUI" user
	    And I complete ft log
		And I logout
	@ivf_ft_log
	Scenario: IVF user completes ft log
		Given I register a new "IVF" user
	    And I complete ft log
		And I logout
	@med_ft_log
	Scenario: MED user completes ft log
		Given I register a new "MED" user
	    And I complete ft log
		And I logout
	@prep_ft_log
	Scenario: PREP user completes ft log
		Given I register a new "PREP" user
	    And I complete ft log
		And I logout				