Feature: Manage transactions
  In order to record what I've spent money on
  I want to be able to record notes against my transactions
  
  Scenario: Adding a note to an existing transaction
    Given the following transactions exist:
      | id | date       | name   | amount |
      | 1  | 2010-01-01 | Shop X | -1     |
    And I am on the transactions page

    When I follow "edit" within "#transaction_1"
    And I fill in "Note" with "Weekly shopping from X"
    And I press "Update"
    
    Then I should be on the transactions page
    And I should see the following transactions:
      | Date        | Name   | Paid out | Note                   |
      | 1 Jan 2010  | Shop X | £0.01    | Weekly shopping from X |

  Scenario: Searching transactions
    Given the following transactions exist:
      | date       | name            | amount |
      | 2010-01-01 | Shop X          | -1     |
      | 2011-01-01 | Cash withdrawal | -1     |
    And I am on the transactions page
    
    When I fill in "Search transactions" with "cash"
    And I press "Search"

    And I should see the following transactions:
      | Date        | Name            |
      | 1 Jan 2011  | Cash Withdrawal |