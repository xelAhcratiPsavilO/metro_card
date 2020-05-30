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
```
Back to [readme](README.md).
