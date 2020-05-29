# Objects & Messages Diagram

Interaction diagram that shows how Objects use Messages to communicate with one another.
```
CLASS           <--       METHOD      --> OUTPUT

Card            <--       balance     --> given balance
Card            <--  top_up(money_in) --> error (if beyond credit max)
Card            <--  top_up(money_in) --> balance + money_in
Card            <-- deduct(money_out) --> error (if under credit min)
Card            <-- deduct(money_out) --> balance - money_out
Card            <--      touch_in     --> true
Card            <--     touch_out     --> false
Card            <--    in_journey?    --> true/false
```
Back to [readme](README.md).
