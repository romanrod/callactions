@api
Feature: Contacts resource
  In order to create contacts
  As a user of the API
  I want to create contacts when I send the proper data to /contacts

Scenario: Create contact
  Given the following body
    """
      {
        "first_name": "Jhon",
        "last_name": "Doe",
        "cell_phone": "1234567",
        "zip_code": 12345
      }
    """
  When I post it to contacts
  Then I should receive 200 OK

Scenario Outline: Contact fields are required and zip code must be numeric
  Given the following body
    """
      {
        "first_name" : "<first_name>",
        "last_name" : "<last_name>",
        "cell_phone" : "<cell_phone>",
        "zip_code" : "<zip_code>"
      }
    """
  When I post it to contacts
  Then I should receive 400 with the '<error message>' on response
Examples:
  |first_name |last_name|cell_phone|zip_code|error message              |
  |jhon       |doe      |1234      |aaaa    |Zip code is not a number   |
  |jhon       |         |1234      |1234    |Last name can't be blank   | 
  |           |doe      |1234      |1234    |First name can't be blank  | 
  |jhon       |doe      |          |1234    |Cell phone can't be blank |
  |jhon       |doe      |1234      |        |Zip code can't be blank   |

Scenario: Contact edition
  Given an existing contact on /contacts
    """
      {
        "first_name": "Jhon",
        "last_name": "Doe",
        "cell_phone": "1234567",
        "zip_code": "12345"
      }
    """
  When I put contact with the body
    """
      {
        "first_name": "Aaron",
        "last_name": "Paterson",
        "cell_phone": "1234567",
        "zip_code": "12345"
      }
    """
  Then the contact resource should be have
    """
      {
        "first_name": "Aaron",
        "last_name": "Paterson",
        "cell_phone": "1234567",
        "zip_code": "12345"
      }
    """

Scenario: Contact deletion