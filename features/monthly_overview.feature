Feature: Monthly overview
  In order to get an idea of my spending habits
  I want to see how much money is 

  Scenario: Viewing the monthly overview
    Given the following transactions exist:
      | date       | name          | type  | amount_in_pence |
      | 2010-12-01 | Transaction 1 | Other | -100            |
      | 2011-01-01 | Transaction 2 | Other | 100             |
      | 2011-02-01 | Transaction 3 | Other | -200            |
      | 2011-02-28 | Transaction 4 | Other | 50              |

    When I view to the monthly overview

    Then I should