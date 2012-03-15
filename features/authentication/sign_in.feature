Feature: Sign in
	In order to access to site
	As a registered user
	I want to sign in to site 
	
	Background:
		Given I have the site: "Journalist" set up
	
	Scenario: Successfully logging in
		When I go to login
		And I fill in "Email" with "admin@advamedia.ru"
		And I fill in "Password" with "qwerty"
		And I press "Log in"
		Then I should see "Profile page"