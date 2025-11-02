# Event Storming - Trick or Treat Finder

## Legend Description
- **Orange Boxes (Domain Events)**: Things that have happened in the system
- **Blue Boxes (Commands)**: User actions that trigger events
- **Green Boxes (Aggregates)**: Clusters of domain objects that maintain consistency
- **Pink Boxes (Policies)**: Business rules that react to events
- **Purple Boxes (Read Models)**: Views of data optimized for specific use cases

## Timeline View

```mermaid
flowchart LR
    %% Legend
    L1[Domain Event]:::event
    L2[Command]:::command
    L3[Aggregate]:::aggregate
    L4[Policy]:::policy
    L5[Read Model]:::readmodel
    
    subgraph Legend
        L1 --- L2 --- L3 --- L4 --- L5
    end

    %% Domain Events in Orange
    E1[User Registered]:::event
    E2[User Logged In]:::event
    E3[User Logged Out]:::event
    E4[Location Registered]:::event
    E5[Location Unregistered]:::event
    E6[Registration Expired]:::event
    
    %% Commands in Blue
    C1[Register User]:::command
    C2[Login]:::command
    C3[Logout]:::command
    C4[Register Location]:::command
    C5[Unregister Location]:::command
    
    %% Aggregates in Green
    A1[User]:::aggregate
    A2[TreatingLocation]:::aggregate
    
    %% Policies in Pink
    P1[Registration Expiry Policy]:::policy
    P2[Location Status Policy]:::policy
    
    %% Read Models in Purple
    RM1[Active Locations]:::readmodel
    RM2[User Profile]:::readmodel
    
    %% Flow
    C1 --> E1
    E1 --> A1
    C2 --> E2
    E2 --> A1
    C3 --> E3
    E3 --> A1
    
    C4 --> E4
    E4 --> A2
    C5 --> E5
    E5 --> A2
    
    P1 --> E6
    E6 --> A2
    
    %% Read Model Updates
    E4 --> RM1
    E5 --> RM1
    E6 --> RM1
    E1 --> RM2
    E2 --> RM2
    
    %% Styling
    classDef event fill:#FFA500,stroke:#333
    classDef command fill:#4169E1,stroke:#333
    classDef aggregate fill:#90EE90,stroke:#333
    classDef policy fill:#FFB6C1,stroke:#333
    classDef readmodel fill:#DDA0DD,stroke:#333
```

## Domain Events (Orange)

### User Registration Flow
- HomeownerRegistered
- LocationVerificationRequested
- LocationVerified
- ProfileCompleted
- GuardianRegistered
- ChildAccountCreated
- ParentalConsentGranted
- GuardianVerificationCompleted

### Location Management
- LocationRegistered
- StatusUpdated
- DescriptionUpdated
- LocationDeactivated
- AreaCreated
- AreaUpdated
- SafetyRatingChanged
- ScareLevelSet
- ScareLevelUpdated
- ScareDescriptionChanged
- AccessPointAdded
- AccessPointUpdated
- AccessPointDeactivated

### Queue Management
- QueueLengthUpdated
- WaitTimeUpdated
- QueueTrendChanged
- HighQueueAlertTriggered
- QueueHistoryRecorded
- PeakTimeIdentified

### Special Location Events
- HauntedHouseRegistered
- DurationEstimateUpdated
- ExitPointRegistered
- CapacityLimitReached
- SpecialInstructionsUpdated

### Route Planning
- RouteFiltered
- ScareLevelPreferenceSet
- MaxScareLevelExceeded
- RouteScareLevelAdjusted

### Trick or Treating
- TreatingSessionStarted
- TreatingSessionEnded
- CandySupplyUpdated
- VisitRecorded
- RouteCreated
- RoutePlanned
- RouteCompleted

### Safety & Tracking
- LocationTrackingEnabled
- LocationTrackingDisabled
- GeofenceViolationDetected
- EmergencyAlertTriggered
- SafetySettingsUpdated
- CustodyScheduleUpdated

### Family Management
- GuardianAccessGranted
- GuardianAccessRevoked
- ChildLocationShared
- EmergencyContactUpdated
- AllowedAreasUpdated
- VisitorCountIncremented

### Search & Discovery
- AreaSearched
- LocationViewed
- RouteGenerated
- SafetyAlertTriggered

## Commands (Blue)

### Homeowner Commands
- RegisterLocation
- UpdateStatus
- UpdateDescription
- StartTreatingSession
- EndTreatingSession
- UpdateCandySupply

### Trick or Treater Commands
- SearchArea
- ViewLocationDetails
- GenerateRoute
- ReportSafetyConcern

## Aggregates (Green)

### TreatingLocation
- Properties:
  * LocationId
  * Address
  * Status
  * Description
  * CandySupply
  * SafetyRating
- Behaviors:
  * Update Status
  * Manage Sessions
  * Track Visitors

### TreatingSession
- Properties:
  * SessionId
  * StartTime
  * EndTime
  * VisitorCount
- Behaviors:
  * Track Visitors
  * Calculate Duration

## Policies (Pink)

- NotificationPolicy
  * Trigger: StatusUpdated
  * Action: Notify nearby trick-or-treaters

- SafetyPolicy
  * Trigger: SafetyAlertTriggered
  * Action: Review location status

- CrowdManagementPolicy
  * Trigger: VisitorCountIncremented
  * Action: Update wait times

## Read Models (Purple)

### LocationMap
- Active treating locations
- Status indicators
- Safety ratings
- Wait times

### TreatingHistory
- Past sessions
- Visitor statistics
- Popular times
- Rating history

## Hot Spots (Red)

1. **Safety Concerns**
   - How to verify locations?
   - What safety metrics to track?
   - When to trigger alerts?

2. **Privacy Issues**
   - What location data to show?
   - How to protect children's privacy?
   - Data retention policies?

3. **Scalability**
   - How to handle peak Halloween traffic?
   - Real-time updates at scale?
   - Geographic partitioning?

## Questions to Resolve

1. **Business Rules**
   - What defines an "active" treating location?
   - How long should sessions last?
   - What's the notification radius?

2. **Technical Decisions**
   - Real-time update mechanism?
   - Offline support strategy?
   - Location accuracy requirements?

3. **User Experience**
   - How to make status updates easy?
   - Navigation experience?
   - Accessibility considerations?

## Next Steps

1. Validate events and flows with stakeholders
2. Identify bounded contexts
3. Define core domain vs supporting domains
4. Create initial domain model
5. Plan first vertical slice