Feature: Manage transactions
  In order to record what I've spent money on
  I want to be able to record notes against my transactions
  
  Scenario: Editing existing transactions
    Given the following transactions exist:
      | id | date       | name   | type  | amount_in_pence |
      | 1  | 2010-01-01 | Shop X | other | -1              |
    And I am on the transactions page for period "2010-01"

    When I follow "Edit"
    And I fill in "transaction[date]" with "2010-01-02" within "#transaction_1"
    And I press "Save date"
    And I fill in "transaction[description]" with "Groceries" within "#transaction_1"
    And I press "Save description"
    And I fill in "transaction[note]" with "Weekly shopping from X" within "#transaction_1"
    And I press "Save note"
    And I go to the transactions page for period "2010-01"
    
    Then I should be on the transactions page
    And I should see the following transactions:
      | Date    | Description | Paid out | Note                   |
      | Sat 2nd | Groceries   | £0.01    | Weekly shopping from X |

  Scenario: Searching transactions
    Given the following transactions exist:
      | date       | name            | type  | amount_in_pence |
      | 2010-01-01 | Shop X          | Other | -1              |
      | 2011-01-01 | Cash withdrawal | Atm   | -1              |
    And I am on the transactions page
    
    When I fill in "Search transactions" with "cash"
    And I press "Search"

    Then I should see "Transactions matching 'cash'"
    And I should see the following transactions:
      | Date           | Description           |
      | Sat 1st Jan 2011 | Cash Withdrawal (Atm) |
  
  Scenario: Viewing transactions for a specific month
    Given the following transactions exist:
      | date       | name            | type  | amount_in_pence |
      | 2011-01-01 | Shop X          | Other | -1              |
      | 2011-02-01 | Cash withdrawal | Atm   | -1              |
    
    When I go to the transactions page for period "2011-01"

    Then I should see "Transactions for January 2011"
    And I should see the following transactions:
      | Date    | Description    |
      | Sat 1st | Shop X (Other) |