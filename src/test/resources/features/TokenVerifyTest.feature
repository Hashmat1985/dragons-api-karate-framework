#Scenario 5:
#ending = /api/token/verify
#with a valid token you should get response HTTP status code
@Smoke @Regression
Feature: Token Verify Test

  Background: Setup Test URL
    Given url "https://tek-insurance-api.azurewebsites.net/"

  Scenario: Verify Vaild Token
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Given path "/api/token/verify"
    And param token = response.token
    And param username = "supervisor"
    When method get
    Then status 200
    And print response
    And assert response == "true"

  #Scenario 6:
  #Endpont = /api/token/verify
  #Wrong username should send as parameter
  #response HTTP Status Code 400
  #and error message "Wrong Username send along with user
  Scenario: Negative test validate token verify with wrong username
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Given path "/api/token/verify"
    And param token = response.token
    And param username = "superviseer"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"

  #Scenario 7:
  #Endpont = /api/token/verify
  #with invalid token and valid username should have
  #Status cokde 400 and error Message "Token expired or invalid token"
  Scenario: Negative test varify Token with invalid token valid username
    Given path "/api/token/verify"
    And param token = "wrong_token"
    And param username = "supervisor"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Token Expired or Invalid Token"
