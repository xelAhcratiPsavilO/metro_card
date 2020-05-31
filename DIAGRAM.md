# Objects & Messages Diagram

Interaction diagram that shows how Objects use Messages to communicate with one another.
```
CLASS           <--        METHOD        --> OUTPUT

Card            <--        balance       --> given balance
Card            <--   top_up(money_in)   --> error (if beyond credit max)
Card            <--   top_up(money_in)   --> balance + money_in
Card            <-- touch_in(a Station)  --> a Station
Card            <-- touch_in(a Station)  --> :entry_station => a Station
Card            <-- touch_out(a Station) --> error (if under credit min)
Card            <-- touch_out(a Station) --> balance - min_fare
Card            <-- touch_out(a Station) --> :exit_station => a Station
Card            <--      journeys        --> []

Station        <--          name         --> given name
Station        <--          zone         --> integer

Journey        <--     entry_station     --> a Station
Journey        <--     exit_station      --> a Station
Journey        <--          fare         --> fare if given exit_station
Journey        <--          fare         --> PENALTY_FARE
Journey        <--   finish(a Station)   --> self
Journey        <--        complete?      --> boolean

JourneyLog     <--    start(a Station)   --> Journey.new
JourneyLog     <--    start(a Station)   --> :entry_station => a Station
JourneyLog     <--    start(a Station)   --> [ a Journey ]
JourneyLog     <--    finish(a Station)  --> :exit_station => a Station
JourneyLog     <--    finish(a Station)  --> current_journey => nil
JourneyLog     <--         journeys      --> []
JourneyLog     <--     current_journey   --> a Journey / nil
```
Back to [readme](README.md).
