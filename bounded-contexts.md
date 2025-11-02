# Bounded Contexts

```mermaid
---
title: Bounded Contexts
---
graph TB
    subgraph Location["Location Management Context"]
        L1[TreatingLocation]
        L2[Address]
        L3[Status]
        L4[TreatingArea]
    end

    subgraph Session["Treating Session Context"]
        S1[TreatingSession]
        S2[VisitorCount]
        S3[CandyInventory]
        S4[Visit]
    end

    subgraph Discovery["Location Discovery Context"]
        D1[LocationMap]
        D2[SearchCriteria]
        D3[Navigation]
        D4[Route]
    end

    subgraph Safety["Safety & Trust Context"]
        T1[Verification]
        T2[Ratings]
        T3[Reports]
        T4[SafetySettings]
    end

    subgraph Family["Family Management Context"]
        F1[Guardian]
        F2[ChildAccount]
        F3[ParentalConsent]
        F4[CustodySchedule]
    end

    subgraph Tracking["Location Tracking Context"]
        TR1[LiveLocation]
        TR2[VisitHistory]
        TR3[GeofencingRules]
        TR4[EmergencyProtocol]
    end

    Location --> Session
    Location --> Discovery
    Location --> Safety
    Session --> Discovery
    Family --> Safety
    Family --> Tracking
    Tracking --> Safety
    Discovery --> Tracking
``
