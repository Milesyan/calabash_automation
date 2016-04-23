@caregiver_signup @regression
Feature: Caregiver signup
  @father_signup
  Scenario: Father should be able to signup
    Given I create a new mother with 1 born girl
    And I create and invite a partner as Father
    And I signup as partner
    And I choose the baby to continue
    And I close premium introduction pop up 
    And I log a poo with start time "10.minutes.ago"
    And I close the insight popup
    And I open "More" page
    And I edit my baby's profile
    Then I should see "Father"
    And I close baby profile page
    And I logout

  @family_member_signup
  Scenario: Family Member should be able to signup
    Given I create a new mother with 1 born boy
    And I create and invite a partner as Family Member
    And I signup as partner
    And I choose the baby to continue
    And I close premium introduction pop up
    And I open "More" page
    And I edit my baby's profile 
    Then I should see "Family Member"
    And I close baby profile page
    And I logout









