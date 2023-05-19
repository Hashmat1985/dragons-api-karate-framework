@Regression
Feature: Get Account API

  #Scenario 8:
  #Endponint = /api/accounts/get-account
  #For primaaryPersonId = <One of your accounts already created
  #Make sure email address is correct.
  Background: API Setup steps
    Given url "https://tek-insurance-api.azurewebsites.net/"

  Scenario: Get Account API Call with existing account
    Given path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    # def step is to define new veriable in Karate Framework
    * def generatedToken = response.token
    Given path "/api/accounts/get-account"
    And param primaryPersonId = 6820
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == 6820
    And assert response.primaryPerson.email == "hashzz@gmail.com"
