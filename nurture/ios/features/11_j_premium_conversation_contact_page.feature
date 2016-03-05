@contact_page
Feature: Check contact page features.

	@follow_contact
	Scenario: The followed people should appear in the contact list

	@non_premium_lock
	Scenario: Non-premium users will see lock icon after other non-premium users; and premium prompt dialog.

	@send_request
	Scenario: Click name of people in contact list with no chat relationship will send a chat request.

	@start_chat
	Scenario: Click name of people with chat relationship established will go to chat window.