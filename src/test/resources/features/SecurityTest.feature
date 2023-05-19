@Smoke @Regression
Feature: API Test Security Section

  Background: Setup Request URL
    Given url "https://tek-insurance-api.azurewebsites.net/"
    And path "/api/token"

  @Test
  Scenario: Create token with vaild username and password.
    #prepare request
    And request {"username": "supervisor","password": "tek_supervisor"}
    #Send request
    When method post
    #Validating response
    Then status 200
    And print response

  Scenario: Create token with wrong username.
    And request {"username": "supervsorr", "password": "tek_supervisor"}
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"

  Scenario: Validate Token with Valid username and Invalid Password
    And request {"username": "supervisor","password": "Teksupervsor"}
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "Password Not Matched"
    And assert response.httpStatus == "BAD_REQUEST"
