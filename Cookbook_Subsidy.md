# Cookbook: Subsidy #

## Resource type ##

  * `payment:Payment`

## Labels ##

  * **Preferred label:** subsidy
  * **Non-preferred labels:** subvention, grant

## Description ##

In Public Contracts Ontology we describe subsidies (amounts of the actual price) supporting the realization of the contract. Since a subsidy does not have the same semantics as price, we use [Payments Ontology](http://data.gov.uk/resources/payments) to specify it.

## Modelling patterns ##

We use `pc:subsidy` property to attach a subsidy to a contract. Its value is an instance of the class `payment:Payment`. This instance has a property `payment:expenditureLine` with a value which is an  instance of class `payment:ExpenditureLine`. Finally, the property `payment:netAmount` of that instance holds the subsidy amount. Its datatype is `xsd:decimal`. The currency of the subsidy is specified using the property `payment:currency` with the value - resource - representing the given currency.

## Example (Turtle) ##

```
<http://www.example.com/resource/sample-contract>
  pc:subsidy <http://www.example.com/resource/sample-contract/payment/1>   .

<http://www.example.com/resource/sample-contract/payment/1>
  a payment:Payment ;
  payment:expenditureLine <http://www.example.com/resource/sample-contract/payment/1/expenditure-line/1> .

<http://www.example.com/resource/sample-contract/payment/1/expenditure-line/1>
  a payment:ExpenditureLine ;
  payment:currency <http://dbpedia.org/resource/Czech_koruna> ;
  payment:netAmount "2000000"^^xsd:decimal .
```