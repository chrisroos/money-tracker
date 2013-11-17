Feature: Manage uploads
  In order to easily get my transactions into the system
  I want to be able to upload an OFX file

  Scenario: Uploading an OFX file
    Given I am on the home page
    And I follow "Upload statement"

    When I attach the file "features/fixtures/example.ofx" to "Ofx file"
    And I press "Upload"

    Then I should be on the transactions page
    And I should see that 2 transactions were imported
    And I should see that there were 0 duplicates

    When I go to the transactions page for period "2011-01"

    Then I should see a credit of £3.21 on 2011-01-02 described as "WAGES / ACME LTD (other)"
    And I should see a debit of £1.23 on 2011-01-01 described as "SHOP X / LONDON (other)"

  Scenario: Not uploading anything
    Given I am on the new upload page

    When I press "Upload"

    Then I should see "Please select the OFX file to upload"

  Scenario: Uploading a duplicate OFX file
    Given I have uploaded "features/fixtures/example.ofx"

    When I upload "features/fixtures/example.ofx"

    Then I should be on the transactions page
    And I should see that 0 transactions were imported
    And I should see that there were 2 duplicates
