# Cookbook: Supplier #

## Resource type ##

  * `gr:BusinessEntity`

## Labels ##

  * **Preferred label:** supplier
  * **Non-preferred labels:** contractor, service provider, company profile, tenderer

## Description ##

Supplier is the company offering to fulfil the contract.

## Modelling patterns ##

We model the suppliers as instances of `gr:BusinessEntity` as in the case of the contracting authority. If the user wants to enable reuse of a description of a BusinessEntity, it is suggested that he models the BusinessEntity separately from a public contract and then reference the BusinessEntity using its URI.

## Example (Turtle) ##

```
<http://www.example.com/resource/sample-contract/tender/2>
  a pc:Tender ;
  pc:supplier <http://www.example.com/resource/sample-supplier> .

<http://www.example.com/resource/sample-supplier>
  a gr:BusinessEntity
  gr:legalName "One Two Three Supplier"^^<http://www.w3.org/2001/XMLSchema#string> ;
  s:address <http://www.example.com/resource/sample-supplier/address> ;
  s:email "onetwothree@example.com"^^<http://www.w3.org/2001/XMLSchema#string> ;
  s:telephone "+420777000000"^^<http://www.w3.org/2001/XMLSchema#string> .

<http://www.example.com/resource/sample-supplier/address>
  a s:PostalAddress ;
  s:streetAddress "Nábřežní"^^<http://www.w3.org/2001/XMLSchema#string> ;
  s:addressLocality "Nový Bor"^^<http://www.w3.org/2001/XMLSchema#string> ;
  s:postalCode "47301"^^<http://www.w3.org/2001/XMLSchema#string> ;
  s:addressCountry "CZ"^^<http://www.w3.org/2001/XMLSchema#string> .
```