@models
Feature: Activity model

Scenario: Add activity to a contact
  Given an existing contact
  When I add the following description to that contact
    """
    this is an activity description
    """
  Then I should see the activity added to contact

Scenario: Acvitity edition
  Given an existing contact
  * with the following activity
    """
    an activity description
    """
  When I edit the activity description with
    """
    an edited activity description
    """
  Then the activity should be updated