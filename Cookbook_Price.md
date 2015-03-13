# Cookbook: Price #

## Resource type ##

  * `gr:UnitPriceSpecification`

## Labels ##

  * **Preferred label:** price
  * **Non-preferred labels:** cost

## Description ##

`gr:UnitPriceSpecification` is used for specifying all kinds of prices that are used in the Public Contracts
Ontology, such as `pc:estimatedPrice` of a contract or `pc:offeredPrice` of a tender.

## Modelling patterns ##

We represent a prices as an instance of `gr:UnitPriceSpecification`. We use properties `gr:hasCurrencyValue` and `gr:hasCurrency` specifying the amount and currency, and `gr:valueAdedTaxIncluded` specifying whether the price includes VAT - this value has a data type of `xsd:boolean`.

See [Unit price Specification](http://www.heppnetz.de/ontologies/goodrelations/v1.html#UnitPriceSpecification) for all details about `gr:UnitPriceSpecification`.

## Example (Turtle) ##

```
<http://www.example.com/resource/sample-contract>
  a pc:Contract ;
  pc:estimatedPrice <http://www.example.com/resource/sample-contract/price-specification/1> ;
  pc:agreedPrice <http://www.example.com/resource/sample-contract/price-specification/3> .

<http://www.example.com/resource/sample-contract/price-specification/1>
  a gr:UnitPriceSpecification
  gr:hasCurrency "CZK" ;
  gr:hasMinCurrencyValue "3500000"^^<http://www.w3.org/2001/XMLSchema#float> ;
  gr:hasMaxCurrencyValue "4000000"^^<http://www.w3.org/2001/XMLSchema#float> ;
  gr:valueAddedTaxIncluded "false"^^<http://www.w3.org/2001/XMLSchema#boolean> .

<http://www.example.com/resource/sample-contract/price-specification/3>
  a gr:UnitPriceSpecification
  gr:hasCurrency "CZK" ;
  gr:hasCurrencyValue "3783381"^^<http://www.w3.org/2001/XMLSchema#float> ;
  gr:valueAddedTaxIncluded "false"^^<http://www.w3.org/2001/XMLSchema#boolean> .
```