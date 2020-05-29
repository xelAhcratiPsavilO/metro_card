# Objects & Messages Diagram

Interaction diagram that shows how Objects use Messages to communicate with one another.
```
CLASS           <--       METHOD      --> OUTPUT

Card            <--       balance     --> given balance
Card            <--  top_up(money_in) --> error (if beyond credit limit)
Card            <--  top_up(money_in) --> balance + money_in
Card            <-- deduct(money_out) --> balance - money_out
```
Back to [readme](README.md).
