# Cookbook: Address #

## Resource type ##

  * `s:PostalAddress `

## Labels ##

  * **Preferred label:** address
  * **Non-preferred labels:**

## Description ##

## Modelling patterns ##

## Example (Turtle) - Identifiers of a public contract ##

```
<http://www.example.com/resource/sample-supplier/address>
  a s:PostalAddress ;
  s:streetAddress "Nábřežní"^^<http://www.w3.org/2001/XMLSchema#string> ;
  s:addressLocality "Nový Bor"^^<http://www.w3.org/2001/XMLSchema#string> ;
  s:postalCode "47301"^^<http://www.w3.org/2001/XMLSchema#string> ;
  s:addressCountry "CZ"^^<http://www.w3.org/2001/XMLSchema#string> .
```