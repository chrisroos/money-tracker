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
      | date       | name            | type    | amount_in_pence |
      | 2010-01-01 | Shop X          | Other   | -1              |
      | 2011-01-01 | Cash withdrawal | Atm     | -100            |
      | 2011-01-01 | Cash deposit    | Deposit | 200             |
    And I am on the transactions page
    
    When I fill in "Search transactions" with "cash"
    And I press "Search"

    Then I should see "Transactions matching 'cash'"
    And I should see that the income of the transactions is £2
    And I should see that the expenditure of the transactions is £1
    And I should see the following transactions:
      | Date             | Description            |
      | Sat 1st Jan 2011 | Cash Withdrawal (Atm)  |
      | Sat 1st Jan 2011 | Cash Deposit (Deposit) |
  
  Scenario: Navigating transaction periods
    Given the following transactions exist:
      | date       | name          | type  | amount_in_pence |
      | 2010-12-01 | Transaction 1 | Other | -100            |
      | 2011-01-01 | Transaction 2 | Other | 100             |
      | 2011-02-01 | Transaction 3 | Other | -200            |
    
    When I go to the transactions page for period "2011-02"

    Then I should see that the income of the transactions is £0
    And I should see that the expenditure of the transactions is £2
    And I should see the following transactions:
      | Date    | Description           |
      | Tue 1st | Transaction 3 (Other) |
      
    When I follow "January 2011"
    
    Then I should see that the income of the transactions is £1
    And I should see that the expenditure of the transactions is £0
    And I should see the following transactions:
      | Date    | Description           |
      | Sat 1st | Transaction 2 (Other) |
      
    When I follow "December 2010"
    
    Then I should see that the income of the transactions is £0
    And I should see that the expenditure of the transactions is £1
    And I should see the following transactions:
      | Date    | Description           |
      | Wed 1st | Transaction 1 (Other) |
    
    When I follow "January 2011"
    
    Then I should see the following transactions:
      | Date    | Description           |
      | Sat 1st | Transaction 2 (Other) |