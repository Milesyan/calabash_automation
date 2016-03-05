@premium @chat_exception
Feature: messages when a chat relationship has exception

	@recipent_message
	Scenario: IF recipient turns off chat, show error message “Message not sent. <User_name>  has turned off chat

	@sender_turn_off
	Scenario:  IF sender turns off chat, show error message “Please turn on chat in your settings to send messages”
