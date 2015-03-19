Feature: Manage transactions
  In order to record what I've spent money on
  I want to be able to record notes against my transactions

  Scenario: Editing multiple transactions
    Given the following transactions exist:
      | id | date       | source_name    | source_type    | source_amount_in_pence |
      | 1  | 2010-01-01 | Shop X  | other   | -1              |
      | 2  | 2010-01-02 | Deposit | deposit | 1               |
    And I am on the transactions page for period "2010-01"

    When I follow "Edit transactions"
    And I fill in "transaction[date]" with "2010-01-02" within "#transaction_1"
    And I press "Save date" within "#transaction_1"
    And I fill in "transaction[description]" with "Groceries" within "#transaction_1"
    And I press "Save description" within "#transaction_1"
    And I fill in "transaction[note]" with "Weekly shopping from X" within "#transaction_1"
    And I press "Save note" within "#transaction_1"
    And I fill in "transaction[category]" with "Household shopping" within "#transaction_1"
    And I press "Save category" within "#transaction_1"
    And I fill in "transaction[date]" with "2010-01-03" within "#transaction_2"
    And I press "Save date" within "#transaction_2"
    And I fill in "transaction[description]" with "Cash deposit" within "#transaction_2"
    And I press "Save description" within "#transaction_2"
    And I fill in "transaction[note]" with "Paid in gift money" within "#transaction_2"
    And I press "Save note" within "#transaction_2"
    And I fill in "transaction[category]" with "Gift" within "#transaction_2"
    And I press "Save category" within "#transaction_2"
    And I go to the transactions page for period "2010-01"

    Then I should be on the transactions page
    And I should see a credit of £0.01 on 2010-01-03 described as "Cash deposit" with a note of "Paid in gift money" in the "Gift" category
    And I should see a debit of £0.01 on 2010-01-02 described as "Groceries" with a note of "Weekly shopping from X" in the "Household shopping" category

  @javascript
  Scenario: Editing multiple transactions with javascript
    Given the following transactions exist:
      | id | date       | source_name    | source_type    | source_amount_in_pence |
      | 1  | 2010-01-01 | Shop X  | other   | -1              |
      | 2  | 2010-01-02 | Deposit | deposit | 1               |
    And I am on the transactions page for period "2010-01"

    When I follow "Edit transactions"
    And I fill in "transaction[date]" with "2010-01-02" within "#transaction_1"
    And I fill in "transaction[description]" with "Groceries" within "#transaction_1"
    And I fill in "transaction[note]" with "Weekly shopping from X" within "#transaction_1"
    And I fill in "transaction[category]" with "Household shopping" within "#transaction_1"
    And I fill in "transaction[date]" with "2010-01-03" within "#transaction_2"
    And I fill in "transaction[description]" with "Cash deposit" within "#transaction_2"
    And I fill in "transaction[note]" with "Paid in gift money" within "#transaction_2"
    And I fill in "transaction[category]" with "Gift" within "#transaction_2"
    And I follow "Recent transactions"
    And I go to the transactions page for period "2010-01"

    Then I should be on the transactions page
    And I should see a credit of £0.01 on 2010-01-03 described as "Cash deposit" with a note of "Paid in gift money" in the "Gift" category
    And I should see a debit of £0.01 on 2010-01-02 described as "Groceries" with a note of "Weekly shopping from X" in the "Household shopping" category

  Scenario: Editing a single transaction
    Given the following transactions exist:
      | id | date       | source_name   | source_type  | source_amount_in_pence |
      | 1  | 2010-01-01 | Shop X | other | -1              |
      | 2  | 2010-01-01 | Shop Y | other | -2              |
    And I am on the transactions page for period "2010-01"

    When I follow "Edit" within "#transaction_1"
    And I fill in "Date" with "2010-01-02"
    And I fill in "Description" with "Groceries"
    And I fill in "Note" with "Weekly shopping from X"
    And I fill in "Category" with "Household shopping"
    And I press "Save"
    And I go to the transactions page for period "2010-01"

    Then I should be on the transactions page
    And I should see a debit of £0.01 on 2010-01-02 described as "Groceries" with a note of "Weekly shopping from X" in the "Household shopping" category
    And I should see a debit of £0.02 on 2010-01-01 described as "Shop Y (other)"

  Scenario: Searching transactions
    Given the following transactions exist:
      | date       | source_name            | source_type    | source_amount_in_pence |
      | 2010-01-01 | Shop X          | Other   | -1              |
      | 2011-01-01 | Cash withdrawal | Atm     | -100            |
      | 2011-01-01 | Cash deposit    | Deposit | 200             |
    And I am on the transactions page

    When I fill in "Search transactions" with "cash"
    And I press "Search"

    Then I should see "Transactions matching 'cash'"
    And I should see that the income of the transactions is £2
    And I should see that the expenditure of the transactions is £1
    And I should see a debit of £1.00 on 2011-01-01 described as "Cash withdrawal (Atm)"
    And I should see a credit of £2.00 on 2011-01-01 described as "Cash deposit (Deposit)"

  Scenario: Editing transactions from a search result
    Given the following transactions exist:
      | id | date       | source_name   | source_type  | source_amount_in_pence |
      | 1  | 2010-01-01 | Shop X | other | -1              |
    And I am on the search results page for the query "shop"

    When I follow "Edit transactions"
    And I fill in "transaction[date]" with "2010-01-02" within "#transaction_1"
    And I press "Save date"
    And I fill in "transaction[description]" with "Groceries" within "#transaction_1"
    And I press "Save description"
    And I go to the transactions page for period "2010-01"

    Then I should see a debit of £0.01 on 2010-01-02 described as "Groceries"

  Scenario: Viewing all transactions with a given category
    Given the following transactions exist:
      | date       | source_name            | source_type    | source_amount_in_pence | category   |
      | 2011-01-01 | Shop X          | Other   | -2000           | Shopping   |
      | 2011-01-02 | Cash withdrawal | Atm     | -100            | Withdrawal |
      | 2011-02-01 | Shop Y          | Other   | -3000           | Shopping   |
    And I am on the transactions page for period "2011-02"

    When I follow "Shopping"

    Then I should see "Transactions matching 'category:Shopping'"
    And I should see a debit of £20.00 on 2011-01-01 described as "Shop X (Other)" in the "Shopping" category
    And I should see a debit of £30.00 on 2011-02-01 described as "Shop Y (Other)" in the "Shopping" category

  Scenario: Viewing all transactions with a given description
    Given the following transactions exist:
      | date       | description     | source_amount_in_pence |
      | 2011-01-01 | Shop X          | -2000           |
      | 2011-01-02 | Cash withdrawal | -100            |
      | 2011-02-01 | Shop X          | -3000           |
    And I am on the transactions page for period "2011-02"

    When I follow "Shop X"
    Then I should see "Transactions matching 'description:Shop X'"
    And I should see a debit of £20.00 on 2011-01-01 described as "Shop X"
    And I should see a debit of £30.00 on 2011-02-01 described as "Shop X"

  Scenario: Navigating transaction periods
    Given the following transactions exist:
      | date       | source_name          | source_type  | source_amount_in_pence |
      | 2010-12-01 | Transaction 1 | Other | -100            |
      | 2011-01-01 | Transaction 2 | Other | 100             |
      | 2011-02-01 | Transaction 3 | Other | -200            |

    When I go to the transactions page for period "2011-02"

    Then I should see that the income of the transactions is £0
    And I should see that the expenditure of the transactions is £2
    And I should see a debit of £2.00 on 2011-02-01 described as "Transaction 3 (Other)"

    When I follow "January 2011"

    Then I should see that the income of the transactions is £1
    And I should see that the expenditure of the transactions is £0
    And I should see a credit of £1.00 on 2011-01-01 described as "Transaction 2 (Other)"

    When I follow "December 2010"

    Then I should see that the income of the transactions is £0
    And I should see that the expenditure of the transactions is £1
    And I should see a debit of £1.00 on 2010-12-01 described as "Transaction 1 (Other)"

    When I follow "January 2011"

    Then I should see a credit of £1.00 on 2011-01-01 described as "Transaction 2 (Other)"
