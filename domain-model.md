# Domain Model

```mermaid
classDiagram
    class TreatingLocation {
        +UUID id
        +Address address
        +String description
        +GeoLocation coordinates
        +TreatingStatus status
        +User owner
        +DateTime lastUpdated
        +updateStatus(TreatingStatus)
        +updateDescription(String)
    }

    class User {
        +UUID id
        +String name
        +String email
        +Role role
        +List~TreatingLocation~ locations
    }

    class TreatingStatus {
        <<enumeration>>
        Open
        Closed
        OutOfCandy
    }

    class TreatingSession {
        +UUID id
        +DateTime startTime
        +DateTime endTime
        +TreatingLocation location
        +int visitorCount
        +bool isActive
    }

    class Address {
        +String street
        +String city
        +String state
        +String postalCode
        +validate()
        +format()
    }

    class GeoLocation {
        +double latitude
        +double longitude
        +calculateDistance(GeoLocation)
    }

    class Role {
        <<enumeration>>
        HomeOwner
        TrickOrTreater
        Administrator
    }

    TreatingLocation "1" -- "1" Address
    TreatingLocation "1" -- "1" GeoLocation
    TreatingLocation "1" -- "1" TreatingStatus
    TreatingLocation "1" -- "1" User
    TreatingSession "0..*" -- "1" TreatingLocation
    User "1" -- "1" Role
```

# Value Objects

```mermaid
classDiagram
    class Address {
        <<Value Object>>
        +String street
        +String city
        +String state
        +String postalCode
    }

    class GeoLocation {
        <<Value Object>>
        +double latitude
        +double longitude
    }

    class Rating {
        <<Value Object>>
        +int score
        +String comment
        +DateTime timestamp
    }
```

# Aggregates

```mermaid
classDiagram
    class TreatingLocationAggregate {
        <<Aggregate Root>>
        +TreatingLocation location
        +List~Rating~ ratings
        +List~TreatingSession~ sessions
        +updateStatus(TreatingStatus)
        +addRating(Rating)
        +startSession()
        +endSession()
    }
```