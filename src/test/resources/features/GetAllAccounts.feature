@Regression
Feature: Get All Accounts Testing
 Background: API get Accounts
  * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"
    
    Scenario: Get All Accounts 
    Given path "/api/accounts/get-all-accounts"
   And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    