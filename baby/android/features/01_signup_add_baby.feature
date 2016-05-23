@signup @regression
Feature: Signup and add babies
  @signup_mother_add_born_boy
  Scenario: Sign up a new mother and add a born boy
    Given I sign up a new mother with birthday "25.years.ago"
    And I add one born boy with birthday "3.days.ago" and due date "3.days.ago"
    And I close premium introduction pop up
    And I logout

  @signup_mother_add_upcoming_girl
  Scenario: Sign up a new mother and add a girl
    Given I sign up a new mother with birthday "13.years.ago"
    And I add one upcoming girl with due date "30.days.since"
    And I close premium introduction pop up
    And I logout

  @signup_father_add_upcoming_boy
  Scenario: Sign up a new father and add a upcoming boy
    Given I sign up a new father with birthday "30.years.ago"
    And I add one upcoming boy with due date "30.days.since"
    And I close premium introduction pop up
    And I logout