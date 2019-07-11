@models
Feature: Contact model
  
Scenario: Create valid contact
  Given the following data for a contact
    |first_name   |Jhon       |
    |last_name    |Doe        |
    |cell_phone   |12345678   |
    |zip_code     |12345      |
  When I save the values into a Contact
  Then contact object should be saved

Scenario Outline: Contact fields are required and zip code must be numeric
  Given the following data for a contact
    |first_name   |<first_name>       |
    |last_name    |<last_name>        |
    |cell_phone   |<cell_phone>       |
    |zip_code     |<zip_code>         |
  When I save the values into a Contact
  Then I should receive the '<error message>' error message 
Examples:
  |first_name |last_name|cell_phone|zip_code|error message              |
  |jhon       |doe      |1234      |aaaa    |Zip code is not a number   |
  |jhon       |         |1234      |1234    |Last name can't be blank   | 
  |           |doe      |1234      |1234    |First name can't be blank  | 
  |jhon       |doe      |          |1234    |Cell phone can't be blank |
  |jhon       |doe      |1234      |        |Zip code can't be blank   |

Scenario: Contact edition
  Given an existing contact with the values
    |first_name   |Jhon       |
    |last_name    |Doe        |
    |cell_phone   |12345678   |
    |zip_code     |12345      |
  When I update contact with the values
    |first_name   |one        |
    |last_name    |two        |
    |cell_phone   |three      |
    |zip_code     |1234       |
  Then the contact should be have
    |first_name   |one        |
    |last_name    |two        |
    |cell_phone   |three      |
    |zip_code     |1234       |

Scenario: Contact deletion
  Given an existing contact with the values
    |first_name   |Jhon       |
    |last_name    |Doe        |
    |cell_phone   |12345678   |
    |zip_code     |12345      |
  And with some activities added
  When I delete the contact
  Then the contact shouldn't exist any more
  And no activities should be present