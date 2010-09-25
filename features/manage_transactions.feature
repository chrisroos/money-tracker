Feature: Manage transactions
  In order to record what I've spent money on
  I want to be able to record notes against my transactions
  
  Scenario: Adding a note to an existing transaction
    Given the following transactions:
      | id | datetime         | description |
      | 1  | 2010-01-01 09:00 | Shop X      |
    And I am on the transactions page

    When I follow "edit" within "#transaction_1"
    And I fill in "Note" with "Weekly shopping from X"
    And I press "Update"
    
    Then I should be on the transactions page
    And I should see the following transactions:
      | Datetime          | Description | Note                   |
      | 01 Jan 2010 09:00 | Shop X      | Weekly shopping from X |
