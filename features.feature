Feature: Trick or Treat Location Management

  As a homeowner offering treats
  I want to register my location and update my treating status
  So that trick-or-treaters can find my house

  Background:
    Given I have installed the Trick or Treat Finder app
    And I have created an account

  Scenario: Register a new treating location
    When I choose to register my location
    And I enter my address "123 Spooky Lane"
    And I add a description "Orange house with pumpkins"
    And I set my initial status to "Closed"
    Then my location should be saved
    And it should appear on the map as "Closed"

  Scenario: Update treating status to Open
    Given I have registered my treating location
    When I update my status to "Open"
    Then my location should show as "Open" on the map
    And nearby trick-or-treaters should be notified

  Scenario: Mark location as Out of Candy
    Given I have registered my treating location
    And my status is "Open"
    When I update my status to "OutOfCandy"
    Then my location should show as "OutOfCandy" on the map
    And I should be removed from active treating locations

Feature: Trick or Treat Route Planning

  As a parent/guardian with trick-or-treaters
  I want to find active treating locations
  So that I can plan an efficient and safe route

  Background:
    Given I have installed the Trick or Treat Finder app
    And location services are enabled

  Scenario: View active treating locations
    When I open the map view
    Then I should see all nearby treating locations
    And each location should show its current status
    And I should see the distance to each location

  Scenario: Filter locations by status
    Given there are treating locations nearby
    When I filter for "Open" locations
    Then I should only see locations marked as "Open"
    And closed or out-of-candy locations should be hidden

  Scenario: Navigate to treating location
    Given I have selected a treating location
    When I request navigation
    Then I should see the recommended walking route
    And estimated time of arrival
    And any safety warnings for the route