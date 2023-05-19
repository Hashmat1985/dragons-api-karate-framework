#End 2 End Account Testing.
# Create Account
# Add Address
# Add Phone
# Add Car
# Get Account
# Note: Everything in 1 Scenario.
Feature: End-to-End Account Testing.

  Background: API Test Setup
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: End-to-End Account Creation Testing
    * def dataGenerator = Java.type('api.data.GenerateData')
* def emailAddressData = dataGenerator.getEmail()
Given path "/api/accounts/add-primary-account"
And header Authorization = "Bearer " + generatedToken
And request
"""
{
  "email": "#(emailAddressData)",
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
And assert response.email == emailAddressData
And assert response.firstName == "Hashmatullah"
* def generatedAccountId = response.id
Given path "/api/accounts/add-account-address"
And param primaryPersonId = generatedAccountId
And header Authorization = "Bearer " + generatedToken
And request 
"""
{
  
  "addressType": "Home",
  "addressLine1": "2244 some Street",
  "city": "Seattle",
  "state": "WA",
  "postalCode": "98003",
  "countryCode": "",
  "current": true
}
"""
When method post
Then status 201
And print response
And assert response.addressLine1 == "2244 some Street"
Given path "/api/accounts/add-account-phone"
And param primaryPersonId = generatedAccountId
And header Authorization = "Bearer " + generatedToken
* def randomPhoneNumber = dataGenerator.getphoneNumber()
And request 
"""
{
  
  "phoneNumber": "#(randomPhoneNumber)",
  "phoneExtension": "",
  "phoneTime": "Morning",
  "phoneType": "Mobile"
}
"""
When method post
Then status 201
And assert response.phoneNumber == randomPhoneNumber
Given path "/api/accounts/add-account-car"
And param primaryPersonId = generatedAccountId
And header Authorization = "Bearer " + generatedToken
* def randomLicensePlate = dataGenerator.getLicensePlate()
And request
"""
{
  
  "make": "Ford",
  "model": "Mustang",
  "year": "2018",
  "licensePlate": "#(randomLicensePlate)"
}
"""
When method post
And status 201
And print response
And assert response.licensePlate == randomLicensePlate




