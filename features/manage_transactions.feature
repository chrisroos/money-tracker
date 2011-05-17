Feature: Manage transactions
  In order to record what I've spent money on
  I want to be able to record notes against my transactions
  
  Scenario: Editing existing transactions
    Given the following transactions exist:
      | id | date       | name   | type  | amount_in_pence |
      | 1  | 2010-01-01 | Shop X | other | -1              |
    And I am on the transactions page

    When I follow "Edit"
    And I fill in "transaction[description]" with "Groceries" within "#transaction_1"
    And I press "Save description"
    And I fill in "transaction[note]" with "Weekly shopping from X" within "#transaction_1"
    And I press "Save note"
    And I follow "Transactions"
    
    Then I should be on the transactions page
    And I should see the following transactions:
      | Date        | Description | Paid out | Note                   |
      | 1 Jan 2010  | Groceries   | £0.01    | Weekly shopping from X |

  Scenario: Searching transactions
    Given the following transactions exist:
      | date       | name            | type  | amount_in_pence |
      | 2010-01-01 | Shop X          | Other | -1              |
      | 2011-01-01 | Cash withdrawal | Atm   | -1              |
    And I am on the transactions page
    
    When I fill in "Search transactions" with "cash"
    And I press "Search"

    And I should see the following transactions:
      | Date        | Description           |
      | 1 Jan 2011  | Cash Withdrawal (Atm) |