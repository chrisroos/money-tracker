Feature: Manage uploads
  In order to easily get my transactions into the system
  I want to be able to upload an OFX file
  
  Scenario: Uploading an OFX file
    Given I am on the home page
    And I follow "Upload statement"
    
    When I attach the file "features/fixtures/example.ofx" to "Ofx file"
    And I press "Upload"
    
    Then I should be on the transactions page
    And I should see the following transactions:
      | Date       | Name   | Memo     | Amount | Note |
      | 1 Jan 2011 | Shop X | London   | £-1.23 |      |
      | 2 Jan 2011 | Wages  | Acme Ltd | £3.21  |      |

  Scenario: Uploading a duplicate OFX file
    Given I have uploaded "features/fixtures/example.ofx"
    
    When I upload "features/fixtures/example.ofx"
    
    Then I should be on the transactions page
    And I should see "2 duplicate transactions were ignored"