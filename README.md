# financestruck

## Data Structure

```
/households/{household}/name // string
/households/{household}/budgets/{budget}/expenses/{expense}/name // localizaed string
/households/{household}/budgets/{budget}/incomes/{income}/name // localizaed string
/households/{household}/budgets/{budget}/transactions/{transaction}/expense // reference to an expense
or
/households/{household}/budgets/{budget}/transactions/{transaction}/income // reference to an income
/households/{household}/budgets/{budget}/transactions/{transaction}/amount/currency // currency string
/households/{household}/budgets/{budget}/transactions/{transaction}/amount/value // number
/households/{household}/budgets/{budget}/transactions/{transaction}/date // timestamp
/households/{household}/budgets/{budget}/transactions/{transaction}/description // string
```

```
/users/{user}/households/{household}/ // reference to an household
```
