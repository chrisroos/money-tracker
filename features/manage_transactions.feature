Feature: Manage transactions
  In order to record what I've spent money on
  I want to be able to record notes against my transactions
  
  Scenario: Adding a note to an existing transaction
    Given the following transactions exist:
      | id | date       | name   | amount |
      | 1  | 2010-01-01 | Shop X | 1      |
    And I am on the transactions page

    When I follow "edit" within "#transaction_1"
    And I fill in "Note" with "Weekly shopping from X"
    And I press "Update"
    
    Then I should be on the transactions page
    And I should see the following transactions:
      | Date        | Name   | Amount | Note                   |
      | 1 Jan 2010  | Shop X | 1      | Weekly shopping from X |
