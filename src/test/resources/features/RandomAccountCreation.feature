@Regression 
Feature: Random Account Creation

Background: Setup Test Generate Token

* def tokenfeature = callonce read ('GenerateToken.feature')
* def token = tokenfeature.response.token
Given url "https://tek-insurance-api.azurewebsites.net"
Scenario: Create Account with Random Email
# Call Java Class and Create Method with Karate
* def dataGenerator = Java.type('api.data.GenerateData')
* def autoEmail = dataGenerator.getEmail()
Given path "/api/accounts/add-primary-account"
And header Authorization = "Bearer " + token
And request
"""
{
  "email": "#(autoEmail)",
  "firstName": "Hashmatullah",
  "lastName": "Azimi",
  "title": "Mr",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Student",
  "dateOfBirth": "1995-01-02"
}
"""
When method post
Then status 201
And print response
And assert response.email == autoEmail